//
//  TipsInterface.swift
//  HelpMeApp
//
//  Created by Nicholas Kevin on 17/11/19.
//  Copyright © 2019 Smith. All rights reserved.
//

import Foundation
import Alamofire

//TIPS INTERFACE
class TipsInterface {
    
    typealias APIResponse = ([[String: Any]])->Void
    func create(tips:TipsModel)
    {
        let tipsJSON = ["username": tips.usernameTips,"title": tips.titleTips, "description": tips.deskripsiTips, "img": tips.imgTips]
          
        let URL:String = "https://helpme.xbanana.id/api/tips";
        
        // 2 - create request
        Alamofire.request(URL,
                          method: .post,
                          parameters: tipsJSON)
            .validate()
            .responseJSON { response in
                // 3 - HTTP response handle
                guard response.result.isSuccess else {
                    print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                    return
                }
                print("########   POST RESPONSE TIPS   ########")
                print(response)
        }
    }
    
    func getAll(_ completion: @escaping APIResponse){
    
        let URL:String = "https://helpme.xbanana.id/api/tips";
        
        // 2 - create request
        Alamofire.request(URL,
                          method: .get)
            .validate()
            .responseJSON { response in
                // 3 - HTTP response handle
                guard response.result.isSuccess else {
                    print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                    return
                }
                print("########   GET RESPONSE TIPS    ########")
                //print(response)
                print(response.value! as! [String: Any])
                completion([response.result.value as! [String : Any]])
                
            
        }
    }
    
    func update(tips:TipsModel)
    {
        let tipsJSON = ["id": tips.id,"username": tips.usernameTips,"title": tips.titleTips, "description": tips.deskripsiTips, "img": tips.imgTips]
          
        let URL:String = "https://helpme.xbanana.id/api/tips";
        
        // 2 - create request
        Alamofire.request(URL,
                          method: .put,
                          parameters: tipsJSON)
            .validate(statusCode: 200..<600)
            .responseJSON { response in
                // 3 - HTTP response handle
                guard response.result.isSuccess else {
                    print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                    return
                }
                print("########   PUT RESPONSE TIPS   ########")
                print(response)
                print()
        }
    }
    func delete(id: String)
    {
       let tipsJSON = ["id": id]
          
        let URL:String = "https://helpme.xbanana.id/api/tips";
        
        // 2 - create request
        Alamofire.request(URL,
                          method: .delete,
                          parameters: tipsJSON)
            .validate(statusCode: 200..<600)
            .responseJSON { response in
                // 3 - HTTP response handle
                guard response.result.isSuccess else {
                    print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                    return
                }
                print("########   DELETE RESPONSE TIPS   ########")
                print(response)
                print()
        }
    }
}
