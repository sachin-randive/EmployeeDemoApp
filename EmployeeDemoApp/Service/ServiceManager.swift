//
//  ServiceManager.swift
//  EmployeeDemoApp
//
//  Created by Sachin Randive on 14/05/20.
//  Copyright © 2020 Sachin Randive. All rights reserved.
//

import Foundation
class ServiceManager {
    static let shared = ServiceManager()
    // Generic function - 'T' stands for Type parameter
    func getEmployeeDetails<T: Decodable> (urlString:String, completionHandler: @escaping(Result<T,NetworkError>) -> ()) {
        guard let serviceURL = URL(string: urlString) else {
            completionHandler(.failure(.badError))
            return
        }
        URLSession.shared.dataTask(with: serviceURL) { (data, response, error) in
            if let err = error {
                completionHandler(.failure(.badError))
                print(err.localizedDescription)
            } else {
                guard let data = data else { return }
                let jsonString = String(decoding: data, as: UTF8.self)
                do {
                    let results = try JSONDecoder().decode(T.self, from: jsonString.data(using: .utf8)!)
                    completionHandler(.success(results))
                } catch {
                    print(error.localizedDescription)
                    completionHandler(.failure(.badError))
                }
            }
            }.resume()
    }
    
    // MARK - Delete API Call
    func deleteEmployeeDetails<T: Decodable> (urlString:String, completionHandler: @escaping(Result<T,NetworkError>) -> ()) {
        guard let serviceURL = URL(string: urlString) else {
            completionHandler(.failure(.badError))
            return
        }
        var request = URLRequest(url: serviceURL)
        request.httpMethod = EEConstants.delete
        request.addValue(EEConstants.applicationJson, forHTTPHeaderField: EEConstants.contentType)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let err = error {
                completionHandler(.failure(.badError))
                print(err.localizedDescription)
            } else {
                guard let data = data else { return }
                let jsonString = String(decoding: data, as: UTF8.self)
                do {
                    let results = try JSONDecoder().decode(T.self, from: jsonString.data(using: .utf8)!)
                    completionHandler(.success(results))
                } catch {
                    print(error.localizedDescription)
                    completionHandler(.failure(.badError))
                }
            }
            }.resume()
    }
    
    // MARK - Delete API Call
    func postEmployeeNewDetails<T: Decodable> (urlString:String, parameterDic:[String:String], completionHandler: @escaping(Result<T,NetworkError>) -> ()) {
        guard let serviceURL = URL(string: urlString) else {
            completionHandler(.failure(.badError))
            return
        }
        var request = URLRequest(url: serviceURL)
        request.httpMethod = EEConstants.post
        
        request.addValue(EEConstants.applicationJson, forHTTPHeaderField: EEConstants.contentType)
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDic, options: []) else {
            return
        }
        request.httpBody = httpBody
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let err = error {
                completionHandler(.failure(.badError))
                print(err.localizedDescription)
            } else {
                guard let data = data else { return }
                let jsonString = String(decoding: data, as: UTF8.self)
                do {
                    let results = try JSONDecoder().decode(T.self, from: jsonString.data(using: .utf8)!)
                    completionHandler(.success(results))
                } catch {
                    print(error.localizedDescription)
                    completionHandler(.failure(.badError))
                }
            }
        }.resume()
    }
}

enum NetworkError: Error {
    case badError
}

