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
        // Do any additional setup after loading the view.

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
                            return print("user email verification sent")
                        }
                        
                        self.handleError(error: error)
                    }
                    
                    print("verify it now")
                }
            }
        }
        signOut()
    }
    
    func signOut() {
        do {
          try Auth.auth().signOut()
          self.dismiss(animated: true, completion: nil)
        } catch (let error) {
          print("Auth sign out failed: \(error)")
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
        case .operationNotAllowed:
            print("operationNotAllowed")
        case .userDisabled:
            print("userDisabled")
        case .userNotFound:
            print("userNotFound")
            self.register(auth: Auth.auth())
        case .tooManyRequests:
            print("tooManyRequests, oooops")
        default: fatalError("error not supported here")
        }
        
    }
    



}
