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
    
    typealias APIResponse = ([[String: Any]])->Void
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProfileByEmail(<#Profile.APIResponse#>)
        
        // Do any additional setup after loading the view.
    }

    func getProfileByEmail(_ completion: @escaping APIResponse){
    
        let email:String = (Auth.auth().currentUser?.email)!
        print(email)
        let profileJSON = ["email": email]
        let URL:String = "https://helpme.xbanana.id/api/profile/getbyemail";
        
        // 2 - create request
        Alamofire.request(URL,
                          method: .post,
                          parameters: profileJSON)
            .validate()
            .responseJSON { response in
                // 3 - HTTP response handle
                guard response.result.isSuccess else {
                    print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                    return
                }
                print("########   POST RESPONSE   ########")
                print(response)
//                let jsonResponse = response.result.value! as! [[String: Any]]
//                let m:UserProfile = UserProfile(json: jsonResponse)
//                    self.userdata = m
                print(response.value! as! [[String: Any]])
                //completion(response.result.value as! [[String : Any]])
                
            
        }
    }

}
