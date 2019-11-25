//
//  UpdateTips.swift
//  HelpMeApp
//
//  Created by Smith on 22/11/19.
//  Copyright © 2019 Smith. All rights reserved.
//

import UIKit

class UpdateTips: UIViewController {
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtDesc: UITextView!
    
    var imgUrl:String = ""
    var tips = TipsModel(id: "", usernameTips: "", titleTips: "", deskripsiTips: "", imgTips: "", datetimeTips: "")
    let tipsManager = TipsInterface()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setForm()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(Register.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    @IBAction func btnConfirm(_ sender: Any) {
        self.tips.titleTips = self.txtTitle.text!
        self.tips.deskripsiTips = self.txtDesc.text
        self.tipsManager.update(tips: tips)
        self.dismiss(animated: true, completion: nil)
    }
    
    func setForm(){
        self.txtTitle.text = self.tips.titleTips
        self.txtDesc.text = self.tips.deskripsiTips
    }
}
