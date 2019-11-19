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
    let reportManager = ReportInterface()
    var allReport = [ReportModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reportManager.getAll() { (json) in
                        for rep in json {
                            print("INI REP : \(rep)")
                            for i in rep{
                                if(i.key == "data"){
                                    print("INI I : \(i)")
                                    print("INI I.VALUE : \(i.value)")
                                    let report = i.value as! [[String : Any]]
                                    var i = 0
                                    for j in report {
                                        //print("INI J : \(j)")
                                        let data = ReportModel(json: j as! [String: Any])
                                        self.allReport.append(data)
                                        print("INI ALL REPORT 1 1 : \(self.allReport[i].description)")
                                        i+=1
                                    }
                                    self.tableView.reloadData()
                                    
//                                    self.username.text! = report["username"] as! String
//                                    self.kategori.text! = report["kategori"] as! String
//                                    self.datetime.text! = report["datetime"] as! String
//                                    self.address.text! = report["address"] as! String
//                                    self.deskripsi.text! = report["deskripsi"] as! String
                                }
                            }
                        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller self.navigationItem.rightBarButtonItem = self.editButtonItem
        }
        self.tableView.reloadData()
        print("INI ALL REPORT : \(self.allReport)")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.allReport.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ReportCustomCell = tableView.dequeueReusableCell(withIdentifier: "ReportCell", for: indexPath) as! ReportCustomCell
        cell.setValue(self.allReport[indexPath.row], forKey: "")
        
        return cell
    }

    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view, boolValue) in
            let id = self.allReport[indexPath.row].id
            print("INI ID : \(id)")
            self.reportManager.delete(id: id) // fungsi delete swipe bagian kanan
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])

        return swipeActions
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .normal, title: "Edit") { (contextualAction, view, boolValue) in
            print("Do Editing...") // fungsi edit swipe dibagian kiri
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])

        return swipeActions
    }

    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
////            tableView.deleteRows(at: [indexPath], with: .automatic)
//            let id = self.allReport[indexPath.row].id
//            print("INI ID : \(id)")
//            self.reportManager.delete(id: id)
//        }
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
