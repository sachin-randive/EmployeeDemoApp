//
//  EmployeeListController.swift
//  EmployeeDemoApp
//
//  Created by Sachin Randive on 15/05/20.
//  Copyright © 2020 Sachin Randive. All rights reserved.
//

import UIKit

class EmployeeListController: UITableViewController {
   fileprivate let model = EmployeeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        model.delegate = self
        model.getEmployeeList()
        tableView.delegate = self
        tableView.dataSource = self
    }

    

   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return model.listOfEmployees.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       var cell : UITableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellIdentifier")
        }

        let ListCurrentItem = model.listOfEmployees[indexPath.row]
        cell.textLabel?.text = ListCurrentItem.employeeName
        cell.detailTextLabel?.text = ListCurrentItem.employeeSalary
       // cell.lblAgeOfEmployee?.text = ListCurrentItem.employeeAge
        cell.imageView?.image = UIImage(named: "Profile_Image")
        cell.selectionStyle = .none

        return cell
    }
     override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    private func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

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
// MARK: - Protocal Delegate
extension EmployeeListController: EmployeeViewModelProtocal {
    func didUpdateData() {
        tableView.reloadData()
       // self.navigationItem.title = UserDefaults.standard.object(forKey:"title") as? String
    }
    
    func didErrorDisplay() {
        let alert = UIAlertController(title: "Error", message: "Fail to load data from server. Please try after sometime.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
