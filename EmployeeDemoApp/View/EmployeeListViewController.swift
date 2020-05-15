//
//  EmployeeListViewController.swift
//  EmployeeDemoApp
//
//  Created by Sachin Randive on 14/05/20.
//  Copyright © 2020 Sachin Randive. All rights reserved.
//

import UIKit

class EmployeeListViewController: UIViewController {
    fileprivate let model = EmployeeViewModel()
    @IBOutlet weak var tableviewOfEmployeeList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate = self
        model.getEmployeeList()
    }
}

// MARK: - Delegate and DataSource Methods
extension EmployeeListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: EEAppConfig.cellIdentifier) as! listTableCell
        cell.accessibilityIdentifier = "myCell_\(indexPath.row)"
        let ListCurrentItem = model.listOfEmployees[indexPath.row]
        cell.lblNameOfEmployee?.text = ListCurrentItem.employeeName
        cell.lblSalaryOfEmployee?.text = ListCurrentItem.employeeSalary
        cell.lblAgeOfEmployee?.text = ListCurrentItem.employeeAge
        cell.profileImageView?.image = UIImage(named: "Profile_Image")
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.listOfEmployees.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    private func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - Protocal Delegate
extension EmployeeListViewController: EmployeeViewModelProtocal {
    func didUpdateData() {
         tableviewOfEmployeeList.reloadData()
       // self.navigationItem.title = UserDefaults.standard.object(forKey:"title") as? String
    }
    
    func didErrorDisplay() {
        let alert = UIAlertController(title: "Error", message: "Fail to load data from server. Please try after sometime.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

