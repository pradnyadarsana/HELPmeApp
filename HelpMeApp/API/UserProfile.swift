//
//  File.swift
//  HelpMeApp
//
//  Created by Smith on 16/11/19.
//  Copyright © 2019 Smith. All rights reserved.
//

import Foundation

class UserProfile{
    var id: String
    var name: String
    var phone: String
    var username: String
    var email: String
    var birthdate: String
    var gender: String
    
    init(json: [String: Any]) {
        self.id = json["id"] as? String ?? ""
        self.name = json["name"] as? String ?? ""
        self.phone = json["phone"] as? String ?? ""
        self.username = json["username"] as? String ?? ""
        self.email = json["email"] as? String ?? ""
        self.birthdate = json["birthdate"] as? String ?? ""
        self.gender = json["gender"] as? String ?? ""
    }
    
    init(id: String, name: String, phone: String, username: String, email: String, birthdate: String, gender: String) {
        self.id = id;
        self.name = name;
        self.phone = phone;
        self.username = username;
        self.email = email;
        self.birthdate = birthdate;
        self.gender = gender;
    }
}
