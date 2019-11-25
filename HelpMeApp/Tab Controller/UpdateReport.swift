//
//  UpdateReport.swift
//  HelpMeApp
//
//  Created by Smith on 17/11/19.
//  Copyright © 2019 Smith. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class UpdateReport: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBAction func loc(_ sender: Any) {
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
                    if let place = places?.first{
                        print("GET ADDRESS")
                        print("name ",place.name)
                        print("administrative area ",place.administrativeArea)
                        print("country ",place.country)
                        print("locality ",place.locality)
                        print("ocean ",place.ocean)
                        print("postal code ",place.postalCode)
                        print("sub administrative area ",place.subAdministrativeArea)
                        print("sub locality ",place.subLocality)
                        print("sub thorough fare ",place.subThoroughfare)
                        print("thorough fare ",place.thoroughfare)
                        print("time zone ",place.timeZone)
                        
                        var locationAddress = String(place.subThoroughfare ?? "sub thoroughfare") + ", " + String(place.thoroughfare ?? "thoroughfare") + ", " + String(place.subAdministrativeArea ?? "sub Administrative area") + ", " + String(place.country!)
                        self.address.text = locationAddress
                        
                    }
                }
            }
        }
    }
    @IBOutlet var category: UITextField!
    @IBOutlet var img: UIImageView!
    @IBOutlet var address: UILabel!
    @IBOutlet var desc: UITextView!
    
    var typeReport = ["Need Help!","Accident","Attention!"]
    var picker = UIPickerView()
    var imgURL:String = ""
    var report = ReportModel(id: "", kategori: "", img: "", address: "", description: "", username: "", datetime: "");
    
    var reportManager = ReportInterface()
    var locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        picker.dataSource = self
        category.inputView = picker
        
        category.text = report.kategori
        imgURL = report.img
        address.text = report.address
        desc.text = report.description
        // Do any additional setup after loading the view.
    }
    
    @IBAction func confirmBtn(_ sender: Any) {
        let report = ReportModel(id: self.report.id, kategori: self.category.text!, img: self.imgURL, address: self.address.text!, description: self.desc.text, username: "", datetime: "")
        self.reportManager.update(report: report)
//        let repClass = Report()
//        repClass.tableView.reloadData();
        self.dismiss(animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return typeReport.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        category.text = typeReport[row]
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return typeReport[row]
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
