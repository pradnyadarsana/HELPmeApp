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
    
    let profileManager = ProfileInterface()
    
    var profile:[String:Any] = ["":""]
    var id:String = ""
    
    private var datePicker: UIDatePicker?
    var picker  = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setForm()
        print("INI ID : \(id)")
        print("INI PROFILE : \(profile)")
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
    
    func setForm(){
        self.fullname.text = self.profile["name"] as! String
        self.phonenumber.text = self.profile["phone"] as! String
        self.email.text = self.profile["email"] as! String
        self.username.text = self.profile["username"] as! String
        self.gender.text = self.profile["gender"] as! String
        self.birthdate.text = self.profile["birth"] as! String
    }
    
    @IBAction func btnConfirm(_ sender: Any) {
        let profile = UserProfile(id: self.id, name: self.fullname.text!, phone: self.phonenumber.text!, username: self.username.text!, email: self.email.text!, birthdate: self.birthdate.text!, gender: self.gender.text!)
        profileManager.update(user: profile)
//        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let profileView = Storyboard.instantiateViewController(identifier: "ProfileVC") as! Profile
//
////        editView.id = profile["id"] as! String
////        editView.profile = profile
//        self.navigationController?.pushViewController(profileView, animated: true)
        
    }

}
