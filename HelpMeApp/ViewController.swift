//
//  ViewController.swift
//  HelpMeApp
//
//  Created by Smith on 01/11/19.
//  Copyright © 2019 Smith. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnRegister(_ sender: Any) {
        performSegue(withIdentifier: "Register", sender: (Any).self)
    }
    
}

