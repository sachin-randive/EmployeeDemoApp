//
//  DataModel.swift
//  EmployeeDemoApp
//
//  Created by Sachin Randive on 14/05/20.
//  Copyright © 2020 Sachin Randive. All rights reserved.
//

import Foundation

// MARK: - DataModel
struct DataModel: Codable {
    let status: String
    let data: [Data]
}

// MARK: - Datum
struct Data: Codable {
    let id, employeeName, employeeSalary, employeeAge: String
    let profileImage: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case employeeName = "employee_name"
        case employeeSalary = "employee_salary"
        case employeeAge = "employee_age"
        case profileImage = "profile_image"
    }
}
