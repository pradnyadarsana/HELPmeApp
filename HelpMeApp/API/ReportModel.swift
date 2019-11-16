//
//  ReportModel.swift
//  HelpMeApp
//
//  Created by Smith on 17/11/19.
//  Copyright © 2019 Smith. All rights reserved.
//

import Foundation

class ReportModel {
    var id: String
    var kategori: String
    var img: String
    var address: String
    var description: String
    var username: String
    var datetime: String
    
    init(json: [String: Any]) {
        self.id = json["id"] as? String ?? ""
        self.kategori = json["kategori"] as? String ?? ""
        self.img = json["img"] as? String ?? ""
        self.address = json["address"] as? String ?? ""
        self.description = json["description"] as? String ?? ""
        self.username = json["username"] as? String ?? ""
        self.datetime = json["datetime"] as? String ?? ""
    }
    
    init(id: String, kategori: String, img: String, address: String, description: String, username: String, datetime: String) {
        self.id = id;
        self.kategori = kategori;
        self.img = img;
        self.address = address;
        self.description = description;
        self.username = username;
        self.datetime = datetime;
    }
}
