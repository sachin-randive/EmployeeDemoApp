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
}

class EmployeeViewModel: NSObject {
    var delegate: EmployeeViewModelProtocal?
    var listOfEmployees : [Data]  = [Data]()
    
    //MARK: - getEmployeeList Methods
    func getEmployeeList() {
        ServiceManager.shared.getEmployeeDetails(urlString: EEAppConfig().employee, completionHandler: { (result: Result<DataModel?, NetworkError>) in
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
}

