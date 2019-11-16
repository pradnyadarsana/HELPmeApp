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
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    override func viewDidAppear(_ animated: Bool) { // Autologin masuk ke Home
        super.viewDidAppear(true)
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
        
        let errorAuthStatus = AuthErrorCode.init(rawValue: error._code)!
        switch errorAuthStatus {
        case .wrongPassword:
            print("wrongPassword")
        case .invalidEmail:
            print("invalidEmail")
            let alert = UIAlertController(title: "Invalid Email", message: "Please enter correct Email Address", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        case .operationNotAllowed:
            print("operationNotAllowed")
        case .userDisabled:
            print("userDisabled")
        case .userNotFound:
            print("userNotFound")
            let alert = UIAlertController(title: "User Not Found", message: "Please Enter Valid User", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        case .tooManyRequests:
            print("tooManyRequests, oooops")
        default: fatalError("error not supported here")
        }
        
    }
}

