//
//  CreateTips.swift
//  HelpMeApp
//
//  Created by Smith on 22/11/19.
//  Copyright © 2019 Smith. All rights reserved.
//

import UIKit

class CreateTips: UIViewController {

    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtDesc: UITextView!
    @IBOutlet weak var photoView: UIImageView!
    
    var profile:[String: Any] = [:]
    var imageLink:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        clearForm()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
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
                                print("INPUTAN")
                                print(self.imageLink)
                                print(self.txtTitle.text as Any)
                                print(self.txtDesc.text as Any)
                                let tipstemp = TipsModel(id: "",
                                                     usernameTips: self.profile["username"] as! String,
                                                     titleTips: self.txtTitle.text!,
                                                     deskripsiTips: self.txtDesc.text,
                                                     imgTips: self.imageLink,
                                                     datetimeTips: "");
                                print("HASIL MODEL")
                                print(tipstemp.titleTips)
                                print(tipstemp.deskripsiTips)
                                print(tipstemp.imgTips)
                                print(tipstemp.id)
                                print(tipstemp.datetimeTips)
                                let tipsManager = TipsInterface()
                                tipsManager.create(tips: tipstemp)
                            }
                        }
                    }
                }
        navigationController?.popViewController(animated: true)
    }
    
    func clearForm(){
        txtTitle.text = ""
        txtDesc.text = ""
        imageLink = ""
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true) // ngilangin keyboard
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
