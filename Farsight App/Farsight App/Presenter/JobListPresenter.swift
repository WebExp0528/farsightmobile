//
//  JobListPresenter.swift
//  Farsight App
//
//  Created by WebDEV on 7/15/21.
//

import Foundation

class JobListPresenter: NSObject {
    private var mView:IJobListView
    private var mJobService:IJobService
       
       
       
    init(withJobService jobService:IJobService, jobListView:IJobListView) {
           self.mView = jobListView
           self.mJobService = jobService
    }
    

    func getJobsList(userId: String) {
            
             mView.showLoader()
        
            self.mJobService.getJobs(byUserId: userId) { (dtoJobs, error) in
         
                if error != nil {
                                         
                    self.mView.hideLoader()
                                          
                    self.mView.showErrorMessage(msg: "Invalid Data!!!")
                                          
                    return
                                 
                }
        
                       
                self.mView.hideLoader()
                self.mView.showJobsList(dtoJobs: dtoJobs ?? nil)
                  
     }
        
    }

    func getJobsDetail(userId: String, won: String) {
            
         if won.isEmpty {
            return
          }
             mView.showLoader()
        
        self.mJobService.getJobDetail(byUserId: userId, won: won) { (dtoDetails, error) in
            
                   if error != nil {
                                            
                       self.mView.hideLoader()
                                             
                       self.mView.showErrorMessage(msg: "Invalid Data!!!")
                                             
                       return
                                    
                   }
           
                          
                   self.mView.hideLoader()
                   self.mView.showJobsDetail(dtoDetail: dtoDetails)
        }
        
    }
    
    func getPhotos(userId: String, won: String) {
            
         if won.isEmpty {
            return
          }
             mView.showLoader()
        
        self.mJobService.getPhotos(byUserId: userId, won: won) { (dtoPhotos, error) in
            
                   if error != nil {
                                            
                       self.mView.hideLoader()
                                             
                       self.mView.showErrorMessage(msg: "Invalid Data!!!")
                                             
                       return
                                    
                   }
           
                          
                   self.mView.hideLoader()
                   self.mView.showJobsPhotos(dtoPhotos: dtoPhotos)
        }
        
    }

}
