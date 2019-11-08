//
//  Register.swift
//  HelpMeApp
//
//  Created by Smith on 02/11/19.
//  Copyright © 2019 Smith. All rights reserved.
//

import UIKit

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



}
