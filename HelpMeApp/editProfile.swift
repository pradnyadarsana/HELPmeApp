//
//  editProfile.swift
//  HelpMeApp
//
//  Created by Nicholas Kevin on 11/11/19.
//  Copyright © 2019 Smith. All rights reserved.
//

import UIKit

class editProfile: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{

    @IBOutlet var fullname: UITextField!
    @IBOutlet var phonenumber: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var username: UITextField!
    @IBOutlet var gender: UITextField!
    @IBOutlet var birthdate: UITextField!
    var list = ["Male", "Female"]

    private var datePicker: UIDatePicker?
    var picker  = UIPickerView()
    @IBAction func btnConfirm(_ sender: Any) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(editProfile.dateChanged(datePicker:)), for: .valueChanged)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(editProfile.viewTapped(gestureRecognizer:)))
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

}
