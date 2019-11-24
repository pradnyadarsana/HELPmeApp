//
//  UpdatePassword.swift
//  HelpMeApp
//
//  Created by Smith on 24/11/19.
//  Copyright © 2019 Smith. All rights reserved.
//

import UIKit
import FirebaseAuth

class UpdatePassword: UIViewController {
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordRetype: UITextField!
    
//    var profil = UserProfile(id: "", name: "", phone: "", username: "", email: "", birthdate: "", gender: "")
//    var id
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnConfirm(_ sender: Any) {
        if(self.password.text==self.passwordRetype.text){
            Auth.auth().currentUser?.updatePassword(to: self.password.text!) { (error) in
                guard error == nil else{
                    return self.handleError(error: error!)
                }
                let alert = UIAlertController(title: "Success!", message: "Your password changed", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }else{
            let alert = UIAlertController(title: "Failed!", message: "Retype your password correctly!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    func handleError(error: Error){
        var message = ""
        
        let errorAuthStatus = AuthErrorCode.init(rawValue: error._code)!
        switch errorAuthStatus {
            case .networkError:
                 print("Network Error")
                 message = "Network Error"
             case .weakPassword:
                 print("Your new password is too weak")
                 message = "Your new password is too weak"
             @unknown default:
                 print("Failed to change you password")
                 message = "Failed to change you password"
        }
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        self.present(alert, animated: true)
    }
    
    func clearForm(){
        self.password.text = ""
        self.passwordRetype.text = ""
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

        
        
}
