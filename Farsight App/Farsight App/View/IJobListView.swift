//
//  IJobListServic.swift
//  Farsight App
//
//  Created by WebDEV on 7/15/21.
//

import Foundation

protocol IJobListView {
    func showLoader()
    func hideLoader()
    func showJobsList(dtoJobs: [DTOJobList]?)
    func showErrorMessage(msg:String)

}
