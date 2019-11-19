//
//  UpdateReport.swift
//  HelpMeApp
//
//  Created by Smith on 17/11/19.
//  Copyright © 2019 Smith. All rights reserved.
//

import UIKit

class UpdateReport: UIViewController {
    
    @IBOutlet var category: UITextField!
    @IBOutlet var img: UIImageView!
    @IBOutlet var address: UILabel!
    @IBOutlet var desc: UITextView!
    
    var imgURL:String = ""
    var report = ReportModel(id: "", kategori: "", img: "", address: "", description: "", username: "", datetime: "");
    
    var reportManager = ReportInterface()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        category.text = report.kategori
        imgURL = report.img
        address.text = report.address
        desc.text = report.description
        // Do any additional setup after loading the view.
    }
    
    @IBAction func confirmBtn(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
