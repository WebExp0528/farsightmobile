//
//  Config.swift
//  Farsight App
//
//  Created by Hamza Malik on 15/07/2021.
//

import Foundation

struct Config {
    
    //MARK: - Constants
   
    static let appKey = "8a2913ae-7fd5-4fea-a286-89d45ca4be2c"
    let ParentURL = "http://"

    //MARK: - Singleton
    static var shared = Config()
    
    //MARK: - Read only properties
    
    var jobListApi:String {
        get {
            if let value = mergeWithParent(self.jobList) {
                return value
            }
            return ""
        }
    }


    
    //MARK: - Private
    private let jobList = "/VerifyLogin"
   
    private func mergeWithParent(_ key: String) -> String? {
        return ParentURL + key
    }
    
    
}
