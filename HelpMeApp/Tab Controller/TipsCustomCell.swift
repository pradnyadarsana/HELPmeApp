//
//  TipsCustomCell.swift
//  HelpMeApp
//
//  Created by Nicholas Kevin on 17/11/19.
//  Copyright © 2019 Smith. All rights reserved.
//

import UIKit


class TipsCustomCell: UITableViewCell {

    
    @IBOutlet weak var usernameTips: UILabel!
    @IBOutlet weak var datetimeTips: UILabel!
    @IBOutlet weak var titleTips: UILabel!
    @IBOutlet weak var deskripsiTips: UITextView!
    
    
    var id:String = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        ///Konfigurasi untuk view saat state Terseleksi
    }
    
    func setValue(_ value: TipsModel?, forKey key: String) {
        self.id = value!.id
        self.usernameTips.text = value?.usernameTips;
        self.titleTips.text = value?.titleTips;
        self.deskripsiTips.text = value?.deskripsiTips;
        self.datetimeTips.text = value?.datetimeTips;

    }

}
