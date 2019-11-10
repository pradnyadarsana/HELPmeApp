//
//  Register.swift
//  HelpMeApp
//
//  Created by Smith on 02/11/19.
//  Copyright © 2019 Smith. All rights reserved.
//

import UIKit
import FirebaseAuth

class Register: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet weak var fullname: UITextField!
    @IBOutlet var phonenumber: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var birthdate: UITextField!
    @IBOutlet weak var gender: UITextField!
    var list = ["Male", "Female"]
    
    private var datePicker: UIDatePicker?
    var picker  = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(Register.dateChanged(datePicker:)), for: .valueChanged)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(Register.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        birthdate.inputView = datePicker
        picker.delegate = self
        picker.dataSource = self
        gender.inputView = picker

    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        gender.text = list[row]
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row]
    }
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    @objc func dateChanged(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        birthdate.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
        
    }
    
    @IBAction func registerBtn(_ sender: Any) {
        register(auth: Auth.auth())
    }
    
    
    
    func register(auth: Auth) {
        auth.createUser(withEmail: email.text!, password: password.text!) { (result, error) in
            guard error == nil else {
                return self.handleError(error: error!)
            }
            guard let user = result?.user else {
                fatalError("Do not know why this would happen")
            }
            print("registered user: \(user.email)")
            user.reload { (error) in
                switch user.isEmailVerified {
                case true:
                    print("users email is verified")
                case false:
                    
                    user.sendEmailVerification { (error) in
                        
                        guard let error = error else {
                            
                            
                            self.signOut()
                            return print("user email verification sent")
                        }
                        
                        self.handleError(error: error)
                    }
                    
                    print("verify it now")
                    let message = "Email verification sent, verify your account now!"
                    let alert = UIAlertController(title: "Success", message: message, preferredStyle: .alert)

                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

                    self.present(alert, animated: true)
                }
            }
        }
        
    }
    
    func signOut() {
        do {
          try Auth.auth().signOut()
          self.dismiss(animated: true, completion: nil)
            clearField()
            print("Auth sign out success")
        } catch (let error) {
          print("Auth sign out failed: \(error)")
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
            message = "Operation Not Allowed"
        case .userDisabled:
            print("userDisabled")
            message = "User Disabled"
        case .userNotFound:
            print("userNotFound")
            message = "User Not Found"
            self.register(auth: Auth.auth())
        case .tooManyRequests:
            print("tooManyRequests, oooops")
            message = "Sorry, Too Many Requests, try again"
        case .emailAlreadyInUse:
            print("Email already used")
            message = "Email already used"
        case .weakPassword:
            print("Your password is to weak")
            message = "Your password is to weak"
        case .missingEmail:
            print("Input email required")
            message = "Input email required"
        default: fatalError("error not supported here")
        }
        
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        self.present(alert, animated: true)
        
    }
    
    
    func clearField(){
        self.fullname.text = ""
        self.username.text = ""
        self.password.text = ""
        self.email.text = ""
        self.birthdate.text = ""
        self.gender.text = ""
    }

}
