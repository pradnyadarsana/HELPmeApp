//
//  TipsModel.swift
//  HelpMeApp
//
//  Created by Nicholas Kevin on 17/11/19.
//  Copyright © 2019 Smith. All rights reserved.
//

import Foundation


class TipsModel {
    var id: String
    var usernameTips: String
    var titleTips: String
    var deskripsiTips: String
    var imgTips: String
    var datetime: String
    
    init(json: [String: Any]) {
        self.id = json["id"] as? String ?? ""
        self.usernameTips = json["username"] as? String ?? ""
        self.titleTips = json["title"] as? String ?? ""
        self.deskripsiTips = json["description"] as? String ?? ""
        self.imgTips = json["img"] as? String ?? ""
        self.datetime = json["datetime"] as? String ?? ""
        
    }
    
    init(id: String, usernameTips: String, titleTips: String,deskripsiTips: String, imgTips: String, datetime: String) {
        self.id = id;
        self.usernameTips = usernameTips;
        self.titleTips = titleTips;
        self.deskripsiTips = deskripsiTips;
        self.imgTips = imgTips;
        self.datetime = datetime;
    }
}
