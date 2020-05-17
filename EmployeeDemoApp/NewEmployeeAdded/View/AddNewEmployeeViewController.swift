//
//  AddNewEmployeeViewController.swift
//  EmployeeDemoApp
//
//  Created by Sachin Randive on 15/05/20.
//  Copyright © 2020 Sachin Randive. All rights reserved.
//

import UIKit
protocol AddNewEmployeeViewControllerProtocal {
    func didReloadTableData()
}

class AddNewEmployeeViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var txtEmployeeName: UITextField!
    @IBOutlet weak var txtSalary: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    
    var addDelegate: AddNewEmployeeViewControllerProtocal?
    fileprivate let employeeViewModel = NewEmployeeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        employeeViewModel.delegate = self
    }
    
    @IBAction func submitButtonAction() {
        guard txtEmployeeName.text!.count > 0 else {
            self.view.showToast(toastMessage: EEConstants.NameRequired, duration: 5.0)
            return
        }
        guard txtSalary.text!.count > 0 else {
            self.view.showToast(toastMessage: EEConstants.SalaryRequired, duration: 5.0)
            return
        }
        guard txtAge.text!.count > 0 else {
            self.view.showToast(toastMessage: EEConstants.AgeRequired, duration: 5.0)
            return
        }
        employeeViewModel.postNewEmployeeRecord(urlString: EEAppConfig().AddNewEmployee, parameter: ["name":txtEmployeeName.text!,"salary":txtSalary.text!,"age":txtAge.text!])
    }
}
// MARK: -  NewEmployeeViewModel Protocal Delegate
extension AddNewEmployeeViewController: NewEmployeeViewModelProtocal {
    func postRecordRespoce(msg: String) {
        self.popupAlert(title: msg, message:EEConstants.sucessMessage, actionTitles: ["OK"], actions:[{action1 in
            DispatchQueue.main.async {
                self.addDelegate?.didReloadTableData()
                self.navigationController?.popViewController(animated: true)
            } }, nil])
    }
    
    func didErrorDisplay() {
        self.alert(message:EEConstants.errorMessage, title: EEConstants.Error)
    }
}

// MARK: - TextField Delegate
extension AddNewEmployeeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // textField delegate method start from here
        if textField == txtEmployeeName || (txtSalary != nil) {
            let maxLength:Int
            if textField == txtEmployeeName {
                maxLength = 15
            } else if textField == txtAge {
                maxLength = 2
            } else {
                maxLength = 8
            }
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        DispatchQueue.main.async {
            textField.text = textField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        textField.resignFirstResponder()
        return true
    }
}
