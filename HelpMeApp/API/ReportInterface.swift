//
//  ReportInterface.swift
//  HelpMeApp
//
//  Created by Smith on 17/11/19.
//  Copyright © 2019 Smith. All rights reserved.
//

import Foundation
import Alamofire
//REPORT INTERFACE
class ReportInterface {
    
    typealias APIResponse = ([[String: Any]])->Void
    
    func create(report:ReportModel)
    {
        let profileJSON = ["kategori": report.kategori, "img": report.img, "address": report.address, "description": report.description, "username": report.username]
          
        let URL:String = "https://helpme.xbanana.id/api/report";
        
        // 2 - create request
        Alamofire.request(URL,
                          method: .post,
                          parameters: profileJSON)
            .validate(statusCode: 200..<600)
            .responseJSON { response in
                // 3 - HTTP response handle
                guard response.result.isSuccess else {
                    print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                    return
                }
                print("########   POST RESPONSE REPORT   ########")
                print(response)
                print()
        }
    }
    
    func getAll(_ completion: @escaping APIResponse){
    
        let URL:String = "https://helpme.xbanana.id/api/report";
        
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
                print("########   GET RESPONSE REPORT    ########")
                //print(response)
                print(response.value! as! [String: Any])
                completion([response.result.value as! [String : Any]])
                
            
        }
    }
    
    func update(report:ReportModel)
    {
        let profileJSON = ["id" : report.id, "kategori": report.kategori, "img": report.img, "address": report.address, "description": report.description]
          
        let URL:String = "https://helpme.xbanana.id/api/report";
        
        // 2 - create request
        Alamofire.request(URL,
                          method: .put,
                          parameters: profileJSON)
            .validate(statusCode: 200..<600)
            .responseJSON { response in
                // 3 - HTTP response handle
                guard response.result.isSuccess else {
                    print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                    return
                }
                print("########   PUT RESPONSE REPORT   ########")
                print(response)
                print()
        }
    }
    func delete(id: String)
    {
        let reportJSON = ["id": id]
          
        let URL:String = "https://helpme.xbanana.id/api/report/delete";
        
        // 2 - create request
        Alamofire.request(URL,
                          method: .post, parameters: reportJSON)
            .validate(statusCode: 200..<600)
            .responseJSON { response in
                // 3 - HTTP response handle
                guard response.result.isSuccess else {
                    print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                    return
                }
                print("########   DELETE RESPONSE REPORT   ########")
                print(response)
        }
    }
}
