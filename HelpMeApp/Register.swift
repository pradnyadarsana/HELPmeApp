//
//  Register.swift
//  HelpMeApp
//
//  Created by Smith on 02/11/19.
//  Copyright © 2019 Smith. All rights reserved.
//

import UIKit

class Register: UIViewController {
    
    @IBOutlet weak var fullname: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var birthdate: UITextField!
    @IBOutlet weak var gender: UITextField!
    var list = ["Male", "Female"]
    
    private var datePicker: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(Register.dateChanged(datePicker:)), for: .valueChanged)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(Register.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        birthdate.inputView = datePicker
        // Do any additional setup after loading the view.
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



}
