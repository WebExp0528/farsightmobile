//
//  Config.swift
//  Farsight App
//
//  Created by Hamza Malik on 15/07/2021.
//

import Foundation

struct Config {
    
    //MARK: - Constants
   
    static let appId = "10a74c1f-1894-49cd-90cc-1f90c3996bf6"
    static let userId = "00903200-EQ00-QUY1-UAA3-1EQUY1EQ1EQU"
    let ParentURL = "http://dev.northsight.io"

    //MARK: - Singleton
    static var shared = Config()
    
    //MARK: - Read only properties
    
    var user_Id: String {
        get {
            return Config.userId
        }
    }
    
    var app_Id: String {
        get {
            return Config.appId
        }
    }


    var jobListURL:String {
        get {
            if let value = mergeWithParent(self.jobList) {
                return value
            }
            return ""
        }
    }


    
    //MARK: - Private
    private let jobList = "/api/work_order/list"
   
    private func mergeWithParent(_ key: String) -> String? {
        return ParentURL + key
    }
    
    
}
