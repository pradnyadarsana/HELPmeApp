//
//  TabController.swift
//  HelpMeApp
//
//  Created by Nicholas Kevin on 08/11/19.
//  Copyright © 2019 Smith. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class TabController: UITabBarController {
var locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
        self.selectedIndex = 0
        locationManager.requestWhenInUseAuthorization()
        var currentLoc: CLLocation!
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
        CLLocationManager.authorizationStatus() == .authorizedAlways) {
           currentLoc = locationManager.location
            let lat = currentLoc.coordinate.latitude
            let long = currentLoc.coordinate.longitude
           print("LAT",lat)
           print("LONG",long)
            let address = CLGeocoder.init()
            address.reverseGeocodeLocation(CLLocation.init(latitude: lat, longitude:long)) { (places, error) in
                if error == nil{
                    if let place = places{
                        print("sakanti",places)
                    }
                }
            }
        }
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
                let Storyboard = UIStoryboard(name: "Main", bundle: nil)
                let editView = Storyboard.instantiateViewController(identifier: "createTipsVC") as! CreateTips
                self.navigationController?.pushViewController(editView, animated: true)
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
