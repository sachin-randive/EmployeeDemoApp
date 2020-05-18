//
//  EmployeeListViewController.swift
//  EmployeeDemoApp
//
//  Created by Sachin Randive on 14/05/20.
//  Copyright © 2020 Sachin Randive. All rights reserved.
//

import UIKit

class EmployeeListViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var tableviewOfEmployeeList: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    //MARK: - Parameters
    fileprivate let model = EmployeeViewModel()
    var reloadDelegate = AddNewEmployeeViewController()
    var resultSearchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
        model.delegate = self
        reloadDelegate.addDelegate = self
        model.getEmployeeList(urlString: EEAppConfig().employee)
        self.showSpinner(onView: self.view)
        tableviewOfEmployeeList.accessibilityIdentifier = "table--tableviewOfEmployeeList"
        addButton.accessibilityIdentifier = "addButton"
        initialiseSearchController()
    }
    func initialiseSearchController() {
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            tableviewOfEmployeeList.tableHeaderView = controller.searchBar
            return controller
        })()
        // Reload the table
        tableviewOfEmployeeList.reloadData()
    }
    @IBAction func AddNewEmployeeRecordAction(_ sender: Any) {
        let nav = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddNewEmployeeID") as! AddNewEmployeeViewController
        nav.addDelegate = self
        self.navigationController?.pushViewController(nav, animated: true)
    }
}

// MARK: - Delegate and DataSource Methods
extension EmployeeListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: EEConstants.cellIdentifier) as! listTableCell
        cell.accessibilityIdentifier = "myCell_\(indexPath.row)"
        let employeeData: Data
        if resultSearchController.isActive && resultSearchController.searchBar.text != "" {
            employeeData = model.filteredEmployeeData[indexPath.row]
        } else {
            employeeData = model.listOfEmployees[indexPath.row]
        }
        cell.lblNameOfEmployee?.text = employeeData.employeeName
        cell.lblSalaryOfEmployee?.text = employeeData.employeeSalary
        cell.lblAgeOfEmployee?.text = employeeData.employeeAge
        cell.profileImageView?.image = UIImage(named: "Profile_Image")
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  (resultSearchController.isActive) {
            return model.filteredEmployeeData.count
        } else {
            return model.listOfEmployees.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    private func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            model.listOfEmployees.remove(at: indexPath.row)
            tableviewOfEmployeeList.deleteRows(at: [indexPath], with: .fade)
            self.showSpinner(onView: self.view)
            model.deleteSingleEmployeeRecord(urlString: EEAppConfig().deleteEmployeeRecord + model.listOfEmployees[indexPath.row].id)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}

// MARK: - Protocal Delegate
extension EmployeeListViewController: EmployeeViewModelProtocal {
    func deleteRecordRespoce(msg: String) {
        self.removeSpinner()
        self.alert(message: msg, title: "")
    }
    
    func didUpdateData() {
        self.removeSpinner()
        tableviewOfEmployeeList.reloadData()
    }
    
    func didErrorDisplay() {  
        self.alert(message:EEConstants.errorMessage, title: EEConstants.Error)
    }
}

// MARK: - UISearchResultsUpdating Delegate
extension EmployeeListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        model.filterSelectedEmployee(for: searchController.searchBar.text ?? "", completionHandler: {
            self.tableviewOfEmployeeList.reloadData()
        })
    }
}
// MARK: - AddNewEmployeeViewControllerProtocal Delegate - refresh after new employee record added
extension EmployeeListViewController: AddNewEmployeeViewControllerProtocal {
    func didReloadTableData() {
        model.getEmployeeList(urlString: EEAppConfig().employee)
    }
}

