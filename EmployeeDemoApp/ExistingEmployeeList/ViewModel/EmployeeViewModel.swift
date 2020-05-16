//
//  EmployeeViewModel.swift
//  EmployeeDemoApp
//
//  Created by Sachin Randive on 14/05/20.
//  Copyright © 2020 Sachin Randive. All rights reserved.
//

import Foundation
import UIKit

protocol EmployeeViewModelProtocal {
    func didUpdateData()
    func didErrorDisplay()
    func deleteRecordRespoce(msg:String)
}

class EmployeeViewModel: NSObject {
    var delegate: EmployeeViewModelProtocal?
    var listOfEmployees : [Data]  = [Data]()
    var filteredEmployeeData = [Data]()
    
    //MARK:- Filter Logic on searchbar
    func filterSelectedEmployee(for searchText: String, completionHandler: @escaping ()-> Void) {
        filteredEmployeeData = listOfEmployees.filter { filteredList in
            return filteredList.employeeName.lowercased().contains(searchText.lowercased())
        }
        completionHandler()
    }
    
    //MARK: - getEmployeeList Methods
    func getEmployeeList(urlString: String) {
        ServiceManager.shared.getEmployeeDetails(urlString: urlString, completionHandler: { (result: Result<DataModel?, NetworkError>) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    guard let response = response  else {
                        self.delegate?.didErrorDisplay()
                        return
                    }
                    self.listOfEmployees = response.data
                    self.delegate?.didUpdateData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    // MARK:- Delete Record Call
    func deleteSingleEmployeeRecord(urlString: String) {
        ServiceManager.shared.deleteEmployeeDetails(urlString: urlString, completionHandler: { (result: Result<DeleteRecordModel?, NetworkError>) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    guard let response = response  else {
                        self.delegate?.didErrorDisplay()
                        return
                    }
                    self.delegate?.deleteRecordRespoce(msg: response.message!)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}

