//
//  CreateReport.swift
//  HelpMeApp
//
//  Created by Smith on 17/11/19.
//  Copyright © 2019 Smith. All rights reserved.
//

import UIKit

class CreateReport: UIViewController {

    @IBOutlet weak var category: UITextField!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var desc: UITextView!
    
    var imageLink:String = ""
    var profile:[String: Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false
        clearForm()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")

        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false

        view.addGestureRecognizer(tap)
    }
    
    @IBAction func submitBtn(_ sender: Any) {
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
                                                         kategori: self.category.text!,
                                                         img: "default image",
                                                         address: self.address.text!,
                                                         description: self.desc.text!,
                                                         username: self.profile["username"] as! String,
                                                         datetime: "")
                                print(report)
                                let reportManager = ReportInterface()
                                reportManager.create(report: report)
                            }
                        }
                    }
                }
        clearForm()
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
