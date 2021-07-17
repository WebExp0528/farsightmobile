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

    
}
