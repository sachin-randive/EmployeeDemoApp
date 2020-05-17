//
//  EmployeeDemoAppTests.swift
//  EmployeeDemoAppTests
//
//  Created by Sachin Randive on 14/05/20.
//  Copyright © 2020 Sachin Randive. All rights reserved.
//

import XCTest
@testable import EmployeeDemoApp

class EmployeeDemoAppTests: XCTestCase {
    var testSession: URLSession!
    
    override func setUp() {
        super.setUp()
        testSession = URLSession(configuration: .default)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        testSession = nil
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    // Asynchronous test: success fast, failure slow
    func testValidCallToGetEmployeeListStatusCode200() {
        // given
        let url = URL(string:EEAppConfig().employee)
        // 1
        let promise = expectation(description: "Status code: 200")
        
        // when
        let dataTask = testSession.dataTask(with: url!) { data, response, error in
            // then
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    // 2
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        // 3
        wait(for: [promise], timeout: 10)
    }
}
