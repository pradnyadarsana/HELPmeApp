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
            let alert = UIAlertController(title: "Create", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
            alert.addAction(UIAlertAction(title: "Back", style: UIAlertAction.Style.cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Report", style: UIAlertAction.Style.default, handler: { (action) in
                    print("Report Selected")
            }))
            alert.addAction(UIAlertAction(title: "Tips", style: UIAlertAction.Style.default, handler: { (action) in
                    print("Tips Selected")
            }))
            self.present(alert, animated: true, completion: nil)
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
