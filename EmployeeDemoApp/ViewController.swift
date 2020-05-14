//
//  ViewController.swift
//  EmployeeDemoApp
//
//  Created by Sachin Randive on 14/05/20.
//  Copyright © 2020 Sachin Randive. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    fileprivate var model = EmployeeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(TTAppConfig().employee)
        model.getEmployeeList()
    }
}

