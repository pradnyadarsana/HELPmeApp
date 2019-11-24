//
//  Tips.swift
//  HelpMeApp
//
//  Created by Nicholas Kevin on 16/11/19.
//  Copyright © 2019 Smith. All rights reserved.
//

import UIKit
import Alamofire
class Tips: UITableViewController {
    let tipsManager = TipsInterface()
    var allTips = [TipsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tipsManager.getAll() { (json) in
//        for rep in json {
//            print("INI REP : \(rep)")
//            for i in rep{
//                if(i.key == "data"){
//                    print("INI I : \(i)")
//                    print("INI I.VALUE : \(i.value)")
//                    let tips = i.value as! [[String : Any]]
//                    var i = 0
//                        for j in tips {
//                            //print("INI J : \(j)")
//                            let data = TipsModel(json: j as! [String: Any])
//                            self.allTips.append(data)
//                            print("INI ALL TIPS 1 1 : \(self.allTips[i].deskripsiTips)")
//                            i+=1
//                        }
//                        self.tableView.reloadData()
//                    }
//                }
//            }
//        }
//        self.tableView.reloadData()
//        print("INI ALL TIPS : \(self.allTips)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        /*self.allTips = []
        self.tableView.reloadData()
        tipsManager.getAll() { (json) in
        for rep in json {
            print("INI REP : \(rep)")
            for i in rep{
                if(i.key == "data"){
                    print("INI I : \(i)")
                    print("INI I.VALUE : \(i.value)")
                    let tips = i.value as! [[String : Any]]
                    var i = 0
                        for j in tips {
                            //print("INI J : \(j)")
                            let data = TipsModel(json: j as! [String: Any])
                            self.allTips.append(data)
                            print("INI ALL TIPS 1 1 : \(self.allTips[i].deskripsiTips)")
                            i+=1
                        }
                        self.tableView.reloadData()
                    }
                }
            }
        }
        //self.tableView.reloadData()
        print("INI ALL TIPS : \(self.allTips)")*/
        self.getdata();
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allTips.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TipsCustomCell = tableView.dequeueReusableCell(withIdentifier: "TipsCell", for: indexPath) as! TipsCustomCell
        cell.setValue(self.allTips[indexPath.row], forKey: "")
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view, boolValue) in
            let id = self.allTips[indexPath.row].id
            print("INI ID : \(id)")
            self.tipsManager.delete(id: id) // fungsi delete swipe bagian kanan
            self.getdata()
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])

        return swipeActions
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .normal, title: "Edit") { (contextualAction, view, boolValue) in
            print("Do Editing...") // fungsi edit swipe dibagian kiri
            let tips = self.allTips[indexPath.row]
            print("INI ID : \(tips.id)")
            print("INI DATA YANG DIEDIT : \(tips.titleTips)")
            print("INI DATA YANG DIEDIT : \(tips.deskripsiTips)")
            print("INI DATA YANG DIEDIT : \(tips.imgTips)")
            print("INI DATA YANG DIEDIT : \(tips.usernameTips)")
            let Storyboard = UIStoryboard(name: "Main", bundle: nil)
            let editView = Storyboard.instantiateViewController(identifier: "updateTipsVC") as! UpdateTips
            editView.tips = tips
            self.navigationController?.showDetailViewController(editView, sender: (Any).self)
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])

        return swipeActions
    }
    
    func getdata(){
        self.allTips = []
        self.tipsManager.getAll() { (json) in
        for rep in json {
            print("INI REP : \(rep)")
            for i in rep{
                if(i.key == "data"){
                    print("INI I : \(i)")
                    print("INI I.VALUE : \(i.value)")
                    let tips = i.value as! [[String : Any]]
                    var i = 0
                        for j in tips {
                            //print("INI J : \(j)")
                            let data = TipsModel(json: j as! [String: Any])
                            self.allTips.append(data)
                            print("INI ALL TIPS 1 1 : \(self.allTips[i].deskripsiTips)")
                            i+=1
                        }
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
}
