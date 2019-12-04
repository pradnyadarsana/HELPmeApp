//
//  ViewController.swift
//  HelpMeApp
//
//  Created by Smith on 01/11/19.
//  Copyright © 2019 Smith. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    @IBOutlet weak var email: SpringTextField!
    @IBOutlet weak var password: SpringTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    override func viewDidAppear(_ animated: Bool) { // Autologin masuk ke Home
        super.viewDidAppear(true)
        //self.navigationController?.isNavigationBarHidden = true
        
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "loginSegue", sender: (Any).self)
        }
        
    }
    @IBAction func signInBtn(_ sender: Any) {
        
        signin(auth: Auth.auth())
        
    }
    
    @IBAction func btnRegister(_ sender: Any) {
        performSegue(withIdentifier: "Register", sender: (Any).self)
    }
    
    
    func signin(auth: Auth) {
        
        auth.signIn(withEmail: email.text!, password: password.text!) { (result, error) in
            guard error == nil else {
                return self.handleError(error: error!)
            }
            
            guard let user = result?.user else{
                fatalError("Not user do not know what went wrong")
            }
            
            user.reload { (error) in
                switch user.isEmailVerified {
                case true:
                    print("users email is verified")
                    self.performSegue(withIdentifier: "loginSegue", sender: (Any).self)
                case false:
                    
                    user.sendEmailVerification { (error) in
                        
                        guard let error = error else {
                            return print("user email verification sent")
                        }
                        
                        self.handleError(error: error)
                    }
                    
                    print("verify it now")
                }
            }
            print("Signed in user: \(user.email)")
            
        }
        
    }
    
    func handleError(error: Error) {
        
        /// the user is not registered
        /// user not found
        var message = ""
        let errorAuthStatus = AuthErrorCode.init(rawValue: error._code)!
        switch errorAuthStatus {
        case .wrongPassword:
            print("wrongPassword")
            message = "Wrong Password"
        case .invalidEmail:
            print("invalidEmail")
            message = "Invalid Email"
        case .operationNotAllowed:
            print("operationNotAllowed")
            message = "Operation not allowed"
        case .userDisabled:
            print("userDisabled")
            message = "User Disabled"
        case .userNotFound:
            print("userNotFound")
            message = "User Not Found, Register now!"
        case .tooManyRequests:
            print("tooManyRequests, oooops")
            message = "Too Many Request now, please try again later"
        case .networkError:
            print("Your Internet MISKIN")
            message = "Your Internet is slow"
        default: fatalError("error not supported here")
        }
        email.animation = "shake"
        email.duration = 1.0
        email.animate()
        password.animation = "shake"
        password.duration = 1.0
        password.animate()
        let alert = UIAlertController(title: "Login Failed", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true) // ngilangin keyboard
    }
}

