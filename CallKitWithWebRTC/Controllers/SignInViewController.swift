//
//  SignInViewController.swift
//  CallKitWithWebRTC
//
//  Created by Venkatrao on 18/12/17.
//  Copyright © 2017 Stellent Soft Pvt Ltd. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var signInButton:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Initializing the signInModel
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(handleTapGesure))
        tapGesture.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    //This action performs when signin button is selected
    @IBAction func signInButtonAction(sender:UIButton)
    {
        self.view.endEditing(true)
        guard !((emailTextField.text?.isEmpty)!) else {
            showAlert(withMessage: "Please enter email")
            return
        }
        guard !((passwordTextField.text?.isEmpty)!) else {
            showAlert(withMessage: "Please enter password")
            return
        }
        guard (self.isValidEmail(testStr: emailTextField.text!)) else {
            showAlert(withMessage: "Enter valid email")
            return
        }
        // Call login API
        let signInMutation = SignInMutation(email: emailTextField.text ?? "", password: passwordTextField.text ?? "", deviceToken: AppDelegate.shared.deviceToken)
        apolloClient.perform(mutation: signInMutation)
        { (result, error) in
            if let error = error
            {
                self.showAlert(withMessage: error.localizedDescription)
            }
            else
            {
                let error = result?.data?.signIn?.error
                _ = (error == true) ? self.showAlert(withMessage: (result?.data?.signIn?.message)!) : self.dismiss(animated: false, completion: nil)
                guard let userID = result?.data?.signIn?.id else{return}
                guard let userName = result?.data?.signIn?.name else{return}
                guard let userEmail = result?.data?.signIn?.email else{return}
                UserDefaults.standard.set(userID, forKey: "userID")
                UserDefaults.standard.set(userName, forKey: "userName")
                UserDefaults.standard.set(userEmail, forKey: "email")
                UserDefaults.standard.synchronize()
                self.performSegue(withIdentifier: "signIn", sender: nil)
            }
        }
    }
    
    //This function is called for setting the statusbar color as white.
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func handleTapGesure(recognizer: UITapGestureRecognizer)
    {
        self.view.endEditing(true)
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with:testStr)
    }
}
// MARK: - Textfield Delegate
extension SignInViewController: UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.location == 0 && string == " "
        {
            return false
        }
        return true
    }
}

