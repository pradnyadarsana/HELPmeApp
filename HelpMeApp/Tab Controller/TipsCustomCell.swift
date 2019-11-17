//
//  TipsCustomCell.swift
//  HelpMeApp
//
//  Created by Nicholas Kevin on 17/11/19.
//  Copyright © 2019 Smith. All rights reserved.
//

import Foundation


class TipsCustomCell: UITableViewCell {

    
    
    var id:String = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setValue(_ value: ReportModel?, forKey key: String) {
        self.id = value!.id
        //self.username.text = value?.username

    }

}
