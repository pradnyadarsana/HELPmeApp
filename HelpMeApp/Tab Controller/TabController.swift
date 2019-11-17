//
//  TabController.swift
//  HelpMeApp
//
//  Created by Nicholas Kevin on 08/11/19.
//  Copyright © 2019 Smith. All rights reserved.
//

import UIKit

class TabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if(item.title == "Create"){
            let alert = UIAlertController(title: "Create", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
            alert.addAction(UIAlertAction(title: "Back", style: UIAlertAction.Style.cancel, handler: {(action) in
                self.selectedIndex = 0;
            }))
            alert.addAction(UIAlertAction(title: "Report", style: UIAlertAction.Style.default, handler: { (action) in
                print("Report Selected")
                ///performSegue(withIdentifier: "CreateReport", sender: TabController())
                let Storyboard = UIStoryboard(name: "Main", bundle: nil)
                let editView = Storyboard.instantiateViewController(identifier: "createReportVC") as! CreateReport
                self.navigationController?.pushViewController(editView, animated: true)
            }))
            alert.addAction(UIAlertAction(title: "Tips", style: UIAlertAction.Style.default, handler: { (action) in
                print("Tips Selected")
                ///performSegue(withIdentifier: "CreateTips", sender: TabController())
            }))
            self.present(alert, animated: true, completion: nil)
        }
            
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
