//
//  ReportCustomCell.swift
//  HelpMeApp
//
//  Created by Smith on 17/11/19.
//  Copyright © 2019 Smith. All rights reserved.
//

import UIKit

class ReportCustomCell: UITableViewCell {
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var datetime: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var desc: UILabel!
    
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
        self.username.text = value?.username
        self.datetime.text = value?.datetime
        self.category.text = value?.kategori
        self.address.text = value?.address
        self.desc.text = value?.description
    }

}
