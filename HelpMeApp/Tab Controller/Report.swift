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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getdata()
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
            self.getdata()
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])

        return swipeActions
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .normal, title: "Edit") { (contextualAction, view, boolValue) in
            print("Do Editing...") // fungsi edit swipe dibagian kiri
            let report = self.allReport[indexPath.row]
            print("INI ID : \(report.id)")
            print("INI DATA YANG DIEDIT : \(report.kategori)")
            print("INI DATA YANG DIEDIT : \(report.img)")
            print("INI DATA YANG DIEDIT : \(report.address)")
            print("INI DATA YANG DIEDIT : \(report.description)")
            let Storyboard = UIStoryboard(name: "Main", bundle: nil)
            let editView = Storyboard.instantiateViewController(identifier: "updateReportVC") as! UpdateReport
            editView.report = report
            self.navigationController?.showDetailViewController(editView, sender: (Any).self)
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
    
    func getdata(){
        self.allReport.removeAll()
        self.tableView.reloadData()
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
                                            
                                        }
                                    }
                                }
            
        }
    }

}
