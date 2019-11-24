//
//  CreateReport.swift
//  HelpMeApp
//
//  Created by Smith on 17/11/19.
//  Copyright © 2019 Smith. All rights reserved.
//

import UIKit

class CreateReport: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return typeReport.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        category.text = typeReport[row]
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return typeReport[row]
    }
    @IBOutlet weak var category: UITextField!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var desc: UITextView!
    
    var imageLink:String = ""
    var profile:[String: Any] = [:]
    var typeReport = ["Need Help!","Accident","Attention!"]
    var picker = UIPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        clearForm()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        
        picker.delegate = self
        picker.dataSource = self
        category.inputView = picker

        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        if self.isMovingFromParent {
            let Storyboard = UIStoryboard(name: "Main", bundle: nil)
            var reportView = Storyboard.instantiateViewController(identifier: "tabController") as! TabController
            reportView.selectedIndex = 0
            self.navigationController?.pushViewController(reportView, animated: true)
        }
        
    }
    
    @IBAction func submitBtn(_ sender: Any) {
        let cat = self.category.text
        let desc = self.desc.text!
        let profileManager = ProfileInterface()
        profileManager.getProfileByEmail(){ (json) in
                    //print(json)
                    for usr in json {
                        //print("INI USR : \(usr)")
                        for i in usr{
                            if(i.key == "data"){
        //                        print("INI I : \(i)")
        //                        print("INI I.VALUE : \(i.value)")
                                self.profile = i.value as! [String : Any]
                                let report = ReportModel(id: "",
                                                         kategori: cat!,
                                                         img: "default image",
                                                         address: self.address.text!,
                                                         description: desc,
                                                         username: self.profile["username"] as! String,
                                                         datetime: "")
                                print(self.category)
                                print(self.description)
                                print(report.kategori)
                                let reportManager = ReportInterface()
                                reportManager.create(report: report)
                            }
                        }
                    }
                }
        clearForm()
        navigationController?.popViewController(animated: true)
    }
    
    func clearForm(){
        category.text = ""
        img.image = UIImage(systemName: "cm_photo_camera_white")
        address.text = "Location"
        desc.text = ""
        self.imageLink = ""
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        view.endEditing(true) // ngilangin keyboard
    }

}
