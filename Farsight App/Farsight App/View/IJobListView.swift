//
//  IJobListServic.swift
//  Farsight App
//
//  Created by Hamza Malik on 15/07/2021.
//

import Foundation

protocol IJobListView {
    func showLoader()
    func hideLoader()
    func showJobsList(dtoJobs: [DTOJobList]?)
    func showErrorMessage(msg:String)

}
