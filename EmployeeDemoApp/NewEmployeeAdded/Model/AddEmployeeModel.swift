//
//  AddEmployeeModel.swift
//  EmployeeDemoApp
//
//  Created by Sachin Randive on 16/05/20.
//  Copyright © 2020 Sachin Randive. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct ResponceClass: Decodable {
    let status: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Decodable {
    let name, salary, age: String?
    let id: Int?
}
