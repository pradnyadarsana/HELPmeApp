//
//  Report.swift
//  HelpMeApp
//
//  Created by Nicholas Kevin on 16/11/19.
//  Copyright © 2019 Smith. All rights reserved.
//

import UIKit
import Alamofire
class Report: UITableViewController {

    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var kategori: UILabel!
    @IBOutlet weak var datetime: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var deskripsi: UILabel!
    
    let reportManager = ReportInterface()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reportManager.getAll() { (json) in
        
                        for usr in json {
                            //print("INI USR : \(usr)")
                            for i in usr{
                                if(i.key == "data"){
            //                        print("INI I : \(i)")
            //                        print("INI I.VALUE : \(i.value)")
                                    let report = i.value as! [String : Any]
                                    //print(self.report)
                                    self.username.text! = report["username"] as! String
                                    self.kategori.text! = report["kategori"] as! String
                                    self.datetime.text! = report["datetime"] as! String
                                    self.address.text! = report["address"] as! String
                                    self.deskripsi.text! = report["deskripsi"] as! String
                                }
                            }
                        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller self.navigationItem.rightBarButtonItem = self.editButtonItem
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
