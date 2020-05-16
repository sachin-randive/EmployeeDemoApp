//
//  NewEmployeeViewModel.swift
//  EmployeeDemoApp
//
//  Created by Sachin Randive on 16/05/20.
//  Copyright © 2020 Sachin Randive. All rights reserved.
//

import Foundation
import UIKit

protocol NewEmployeeViewModelProtocal {
     func postRecordRespoce(msg:String)
     func didErrorDisplay()
}

class NewEmployeeViewModel: NSObject {
      var delegate: NewEmployeeViewModelProtocal?
    
    //MARK: - PostNewEmployeeData Methods
    func postNewEmployeeRecord(urlString: String, parameter:[String:String]) {
        ServiceManager.shared.postEmployeeNewDetails(urlString: urlString, parameterDic: parameter, completionHandler: { (result: Result<ResponceClass?, NetworkError>) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    guard let response = response  else {
                        self.delegate?.didErrorDisplay()
                        return
                    }
                   // self.listOfEmployees = response.status
                    self.delegate?.postRecordRespoce(msg:response.status)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }

}
