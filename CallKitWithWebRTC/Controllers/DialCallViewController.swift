//
//  DialCallViewController.swift
//  CallKitWithWebRTC
//
//  Created by Venkatrao on 18/12/17.
//  Copyright © 2017 Stellent Soft Pvt Ltd. All rights reserved.
//

import UIKit
import WebRTC
import AVFoundation

class DialCallViewController: UIViewController {
    
    //Views, Labels, and Buttons
    @IBOutlet weak var muteButton:UIButton?
    @IBOutlet weak var speakerButton:UIButton?
    @IBOutlet weak var callEndButton:UIButton?
    @IBOutlet weak var callerNameLabel:UILabel?
    @IBOutlet weak var callDurationLabel:UILabel?
    @IBOutlet weak var profileImage:UIImageView?
    
    var client:ARDAppClient?
    var roomName:String?
    var handle:String = ""
    var captureController:ARDCaptureController = ARDCaptureController()
    var callTimer = Timer()
    var callTimeOutimer = Timer()
    var callDurationInterval = 0
    
    var isCallConnected = false
    
    let callManager = AppDelegate.shared.callManager
    var currentCall:Call?
    var isIncomingCall = false
    var callInitiateTime:Date!
    var callStartTime:Date!
    var callEndTime:Date!
    var roomID:String!
    var currentUser:ListUsersQuery.Data.ListUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callDurationLabel?.text = "Please wait while connecting..."
        AppDelegate.shared.providerDelegate.callVc = self
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.disconnect()
        self.client=ARDAppClient(delegate: self)
        
        callManager.callsChangedHandler = { [weak self] in
            guard let strongSelf = self else { return }
            if (self?.callManager.calls.count)! > 0
            {
                self?.currentCall = self?.callManager.calls[0]
            }
        }
        if !isIncomingCall
        {
            callerNameLabel?.text = currentUser?.name
            self.initiateCall()
        }
        else
        {
            callerNameLabel?.text = AppDelegate.shared.handle
            let settingsModel = ARDSettingsModel()
            client!.connectToRoom(withId: self.roomName! as String!, settings: settingsModel, isLoopback: false, isAudioOnly: true, shouldMakeAecDump: false, shouldUseLevelControl: false)
            
            callTimeOutimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(callTimeOut), userInfo: nil, repeats: false)
        }
    }
    
    override func  viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        callTimer.invalidate()
        callTimeOutimer.invalidate()
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func muteButtonPressed (_ sender:UIButton){
        sender.isSelected = !sender.isSelected
        self.client?.toggleAudioMute()
    }
    @IBAction func speakerButtonPressed(_ sender:UIButton){
        DispatchQueue.main.async {
            sender.isSelected = !sender.isSelected
            self.speakerOnOrOff(sender: sender)
        }
    }
    func speakerOnOrOff(sender:UIButton)
    {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        }
        catch _ as NSError {}
        do {
            try session.setMode(AVAudioSessionModeVoiceChat)
        }
        catch _ as NSError {}
        do {
            if !sender.isSelected
            {
                try AVAudioSession.sharedInstance().overrideOutputAudioPort(AVAudioSessionPortOverride.none)
            }
            else
            {
                try AVAudioSession.sharedInstance().overrideOutputAudioPort(AVAudioSessionPortOverride.speaker)
            }
        } catch let error as NSError {
            print("audioSession error: \(error.localizedDescription)")
        }
    }
    @IBAction func callEndButtonPressed(_ sender:UIButton){
        if callManager.calls.count > 0
        {
            for call in callManager.calls {
                call.end()
                callManager.end(call: call)
            }
        }
        AppDelegate.shared.isIncomingCall = false
        AppDelegate.shared.roomID = ""
        self.disconnect()
        dismiss(animated: true, completion: nil)
    }
    
    func disconnect(){
        if let _ = self.client{
            self.client?.disconnect()
            self.callTimer.invalidate()
            self.callTimeOutimer.invalidate()
        }
    }
    
    @objc func updateCallDuration()
    {
        callDurationInterval += 1
        self.callDurationLabel?.text =  getTimeString(FromTimeInterval: TimeInterval(callDurationInterval))
    }
    @objc func callTimeOut()
    {
        self.callTimeOutimer.invalidate()
        self.callDurationLabel?.text = "Call End"
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.callEndButtonPressed(self.callEndButton!)
        }
    }
    func getTimeString(FromTimeInterval time:TimeInterval) -> String
    {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02d:%02d:%02d", hours, minutes, seconds)
    }
    func initiateCall()
    {
        let callerUserId = UserDefaults.standard.value(forKey: "userID") as! String
        let uuid = UUID().uuidString
        handle = UserDefaults.standard.value(forKey: "userName") as! String
        let callMutation = InitiateCallMutation(caller: callerUserId, receiver: currentUser?.id, handleName: handle, UUID: uuid)
        apolloClient.perform(mutation: callMutation)
        { (result, error) in
            if let error = error
            {
                self.callEndButtonPressed(self.callEndButton!)
                NSLog(error.localizedDescription)
            }
            else
            {
                
                let notificationData = result?.data?.initiateCall
                guard let roomName = notificationData?.roomName else {self.callEndButtonPressed(self.callEndButton!);return}
                guard let roomID = notificationData?.id else {self.callEndButtonPressed(self.callEndButton!);return}
                self.roomID = roomID
                self.roomName = roomName
                
                let settingsModel = ARDSettingsModel()
                self.client!.connectToRoom(withId: self.roomName! as String!, settings: settingsModel, isLoopback: false, isAudioOnly: true, shouldMakeAecDump: false, shouldUseLevelControl: false)
                self.callManager.startCall(handle: self.currentUser?.name ?? "", videoEnabled: false)
                self.callTimeOutimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(self.callTimeOut), userInfo: nil, repeats: false)
                self.callInitiateTime = Date()
            }
        }
    }
}
extension DialCallViewController : ARDAppClientDelegate
{
    func appclient(_ client: ARDAppClient!, didRotateWithLocal localVideoTrack: RTCVideoTrack!, remoteVideoTrack: RTCVideoTrack!) {
        
    }
    
    public func appClient(_ client: ARDAppClient!, didGetStats stats: [Any]!) {
        print(#function)
        print("\(stats)")
    }
    
    public func appClient(_ client: ARDAppClient!, didChange state: RTCIceConnectionState) {
        print("appclient state is \(state.hashValue)")
        if state == RTCIceConnectionState.connected
        {
            self.isCallConnected = true
            self.callTimeOutimer.invalidate()
            self.callDurationLabel?.text =  "00:00:00"
            self.callTimer.invalidate()
            self.callTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCallDuration), userInfo: nil, repeats: true)
            self.callStartTime = Date()
        }
        else if state == RTCIceConnectionState.checking
        {
            callDurationLabel?.text = "Checking..."
        }
        else if state == RTCIceConnectionState.new
        {
            callDurationLabel?.text = "Establishing Connection..."
        }
        
    }
    
    func appClient(_ client: ARDAppClient!, didChange state: ARDAppClientState) {
        switch (state) {
        case .connected:
            print("Client connected.");
            if !isIncomingCall
            {
                self.currentCall?.state = .active
                self.currentCall?.connectedState = .complete
            }
        case .connecting:
            print("Client connecting.");
        case .disconnected:
            print("Client disconnected.");
            self.callDurationLabel?.text = "Disconnected"
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.callEndButtonPressed(self.callEndButton!)
            }
            
        }
    }
    
    public func appClient(_ client: ARDAppClient!, didError error: Error!) {
        
        DispatchQueue.main.async {
            self.callDurationLabel?.text = error.localizedDescription
            self.disconnect()
        }
    }
    
    func appClient(_ client: ARDAppClient!, didReceiveLocalVideoTrack localVideoTrack: RTCVideoTrack!) {
    }
    
    public func appClient(_ client: ARDAppClient!, didCreateLocalCapturer localCapturer: RTCCameraVideoCapturer!) {
        let settingsModel = ARDSettingsModel()
        captureController = ARDCaptureController(capturer: localCapturer, settings: settingsModel)
        captureController.startCapture()
    }
    
    func appClient(_ client: ARDAppClient!, didReceiveRemoteVideoTrack remoteVideoTrack: RTCVideoTrack!) {
        
    }
    
}


