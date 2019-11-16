//
//  Profile.swift
//  
//
//  Created by Nicholas Kevin on 16/11/19.
//

import UIKit
import FirebaseAuth
import Alamofire

class Profile: UIViewController {

    @IBOutlet weak var fullname: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var birthday: UILabel!
    @IBOutlet weak var gender: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let profileManager = ProfileInterface()
        profileManager.getProfileByEmail(){ (json) in
            
            //print(json)
            for usr in json {
                //print("INI USR : \(usr)")
                for i in usr{
                    if(i.key == "data"){
//                        print("INI I : \(i)")
//                        print("INI I.VALUE : \(i.value)")
                        let profile = i.value as! [String : Any]
                        //print(self.profile)
                        self.fullname.text! = profile["name"] as! String
                        self.username.text! = profile["username"] as! String
                        self.email.text! = profile["email"] as! String
                        self.phone.text! = profile["phone"] as! String
                        self.gender.text! = profile["gender"] as! String
                        self.birthday.text! = profile["birth"] as! String
                    }
                }
            }
            
        }
        
        
        // Do any additional setup after loading the view.
    }

    

}
