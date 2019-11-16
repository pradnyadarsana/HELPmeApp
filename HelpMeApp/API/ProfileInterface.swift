//
//  ProfileInterface.swift
//  HelpMeApp
//
//  Created by Smith on 16/11/19.
//  Copyright © 2019 Smith. All rights reserved.
//

import Foundation
import Alamofire
import FirebaseAuth

class ProfileInterface {
    
    func create(user:UserProfile)
    {
        let profileJSON = ["name": user.name, "phone": user.phone, "email": user.email, "username": user.username, "birth": user.birthdate, "gender": user.gender]
          
        let URL:String = "https://helpme.xbanana.id/api/profile";
        
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
                print()
        }
    }
        
    func getProfileByEmail(){
        
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
                print(response.result.value!)
                //completion(response.result.value as! [[String : Any]])
                
        }
        //return responseData
        
        
    }
}
