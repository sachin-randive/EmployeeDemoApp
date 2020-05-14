//
//  TTAppConfig.swift
//  EmployeeDemoApp
//
//  Created by Sachin Randive on 14/05/20.
//  Copyright © 2020 Sachin Randive. All rights reserved.
//

import Foundation

struct TTAppConfig {
    // Comman Base URL
    private  let authoriseBaseURL = "http://dummy.restapiexample.com/api/v1/"
    // Employee URL String
    var employee: String {
        return authoriseBaseURL + "employees"
    }
}
