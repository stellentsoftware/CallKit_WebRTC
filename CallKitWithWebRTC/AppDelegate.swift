//
//  AppDelegate.swift
//  CallKitWithWebRTC
//
//  Created by Venkatrao on 18/12/17.
//  Copyright © 2017 Stellent Soft Pvt Ltd. All rights reserved.
//

import UIKit
import WebRTC
import PushKit
import Apollo

let apolloClient = ApolloClient(url: URL(string: "http://talents.myappdemo.us/graphql?")!)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var providerDelegate: ProviderDelegate!
    let callManager = CallManager()
    let pushRegistry = PKPushRegistry(queue: DispatchQueue.main)
    var roomID = ""
    var isIncomingCall = false
    var handle = ""
    var deviceToken:String  = ""
    var incomingCallTimeOutTimer = Timer()
    class var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        apolloClient.cacheKeyForObject = { $0["_id"] } // assigning unique id of our records to caching purpose
        RTCInitializeSSL()
        providerDelegate = ProviderDelegate(callManager: callManager)
        pushRegistry.delegate = self
        pushRegistry.desiredPushTypes = [.voIP]
        AVAudioSession.sharedInstance().requestRecordPermission { (granted) in }
        
        if(UserDefaults.standard.value(forKey: "userID") != nil)
        {
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            let navVC = mainStoryBoard.instantiateViewController(withIdentifier: "NavVC") as! UINavigationController
            let vc = mainStoryBoard.instantiateViewController(withIdentifier: "usersVC") as! UsersListViewController
            navVC.pushViewController(vc, animated: false)
            self.window?.rootViewController = navVC
        }
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        RTCCleanupSSL();
    }
    
    
}

extension AppDelegate: PKPushRegistryDelegate {
    
    func pushRegistry(_ registry: PKPushRegistry, didUpdate credentials: PKPushCredentials, for type: PKPushType) {
        print("\(#function) voip token: \(credentials.token)")
        
        deviceToken = credentials.token.reduce("", {$0 + String(format: "%02X", $1) })
        NSLog("\(#function) token is: \(deviceToken)")
    }
    
    func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for type: PKPushType) {
        
        NSLog("\(#function) incoming voip notfication: \(payload.dictionaryPayload)")
        if(UserDefaults.standard.value(forKey: "userID") != nil)
        {
            guard let incomingCallDict = payload.dictionaryPayload ["aps"] as? [String:Any] else {return}
            if let uuidString = incomingCallDict["UUID"] as? String,
                let handle = incomingCallDict["handleName"] as? String, let roomName = incomingCallDict["roomName"] as? String,
                let uuid = UUID(uuidString: uuidString) {
                self.roomID = roomName
                self.isIncomingCall = true
                self.handle = handle
                // display incoming call UI when receiving incoming voip notification
                let backgroundTaskIdentifier = UIApplication.shared.beginBackgroundTask(expirationHandler: nil)
                self.displayIncomingCall(uuid: uuid, handle: handle, hasVideo: false) { _ in
                    UIApplication.shared.endBackgroundTask(backgroundTaskIdentifier)
                }
            }
        }
    }
    
    func pushRegistry(_ registry: PKPushRegistry, didInvalidatePushTokenFor type: PKPushType) {
        print("\(#function) token invalidated")
    }
    
    /// Display the incoming call to the user
    func displayIncomingCall(uuid: UUID, handle: String, hasVideo: Bool = false, completion: ((NSError?) -> Void)? = nil) {
        providerDelegate?.reportIncomingCall(uuid: uuid, handle: handle, hasVideo: hasVideo, completion: completion)
    }
}
