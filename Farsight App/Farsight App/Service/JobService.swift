//
//  JobService.swift
//  Farsight App
//
//  Created by Hamza Malik on 15/07/2021.
//

import Foundation
import Alamofire
protocol IJobService {
      typealias ResponseJobList = (DTOJobList ,Error?) -> Void

    func getJobs(byUserId userId: String, pageId: String, completion: @escaping ResponseJobList)

    

    
}
class JobService: IJobService {
    
       
    func getJobs(byUserId userId: String, pageId: String, completion: @escaping ResponseJobList) {
        let params = ["userID": userId, "pageID": pageId]

             AF.request(Config.shared.jobListApi, method: .get, parameters: params).validate().responseJSON{ response in
                   
                completion(DTOJobList(),nil)
        }

            
    }
    




     
    
}
