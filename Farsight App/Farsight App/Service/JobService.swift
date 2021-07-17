//
//  JobService.swift
//  Farsight App
//
//  Created by WebDEV on 7/15/21.
//

import Foundation
import Alamofire
protocol IJobService {
    typealias ResponseJobList = ([DTOJobList]? ,Error?) -> Void
    typealias ResponseJobDetail = (DTOJobDetail? ,Error?) -> Void
    typealias ResponseJobPhotos = ([DTOPhotos]? ,Error?) -> Void

    func getJobs(byUserId userId: String, completion: @escaping ResponseJobList)
    func getJobDetail(byUserId userId: String, won: String ,completion: @escaping ResponseJobDetail)
    func getPhotos(byUserId userId: String, won: String ,completion: @escaping ResponseJobPhotos)


    
}
class JobService: IJobService {
 
    func convertDATtoDTOPhotos(i: [[String:String]]) -> [DTOPhotos] {
        
        var photos = [DTOPhotos]()
        for photo in i {
    
            let dtoPhoto = DTOPhotos(label: (photo["label"] as? String) ?? "", image_url_full: (photo["image_url_full"] as? String) ?? "")
            photos.append(dtoPhoto)
        }
       return photos
    }

    func convertDATtoDTOJobDetail(i: [String:AnyObject]) -> DTOJobDetail {
        
        
        
        
        
        var last_status_update:LastStatusUpdate?
        var instructionsFullList: [InstructionsFull] = []
        
        
        if let last_statusUpdate = i["last_status_update"] as? [String:Any] {
            
            var delay_reason = ""
            var explanation = ""
            var order_status = ""
            var won  = ""
            var expected_upload_date = ""
            
            
            if let delayreason = last_statusUpdate["delay_reason"] as? String {
                delay_reason = delayreason
            }
            if let explan = last_statusUpdate["explanation"] as? String {
                explanation = explan
            }
            if let orderstatus = last_statusUpdate["order_status"] as? String {
                order_status = orderstatus
            }
            if let expected_uploadDate = last_statusUpdate["expected_upload_date"] as? String {
                expected_upload_date = expected_uploadDate
            }
            if let wonn = i["won"] as? String {
                won = wonn
            }
            last_status_update = LastStatusUpdate(delay_reason: delay_reason, expected_upload_date: expected_upload_date, explanation: explanation, order_status: order_status, won: won)
                
        }
        
        if let instructionsFull = i["instructions_full"] as? [[String:Any]] {
            
            var type: String = ""
            var action: String = ""
            var instruction: String = ""
            for ins in instructionsFull {
            
            if let typee = ins["type"] as? String {
                type = typee
            }
            if let act = ins["action"] as? String {
                action = act
            }
            if let instr = ins["instruction"] as? String {
                instruction = instr
            }
            instructionsFullList.append(InstructionsFull(type: type, action: action, instruction: instruction))
        
           
       
            }
            
        }
     
            
        return DTOJobDetail(api_user: (i["api_user"] as? String) ?? "", vendor_name:  (i["vendor_name"] as? String) ?? "", support_contact: (i["support_contact"] as? String) ?? "", won: (i["won"] as? String) ?? "", uri: (i["uri"] as? String) ?? "", due_date: (i["due_date"] as? String) ?? "", created_date: (i["created_date"] as? String) ?? "", address_street: (i["address_street"] as? String) ?? "", address_city: (i["address_city"] as? String) ?? "", address_state: (i["address_state"] as? String) ?? "", address_zip_code: (i["address_zip_code"] as? String) ?? "", gps_latitude: (i["gps_latitude"] as? String) ?? "", gps_longitude: (i["gps_longitude"] as? String) ?? "", image_url_tiny2: (i["image_url_tiny2"] as? String) ?? "", image_url_tiny: (i["image_url_tiny"] as? String) ?? "", image_url_small: (i["image_url_small"] as? String) ?? "", image_url_medium: (i["image_url_medium"] as? String) ?? "", image_url_full: (i["image_url_full"] as? String) ?? "", interior_access_needed: (i["interior_access_needed"] as? Bool) ?? false, lot_size_sq_ft: (i["lot_size_sq_ft"] as? Int) ?? 0, priority: (i["priority"] as? Int) ?? 0, work_order_type: (i["work_order_type"] as? String) ?? "", work_ordered: (i["work_ordered"] as? String) ?? "", app_action: (i["app_action"] as? String) ?? "", source_won: (i["source_won"] as? String) ?? "", status: (i["status"] as? String) ?? "", instructions_full: instructionsFullList, last_status_update: last_status_update)
    }
    func convertDATtoDTOJobList(value: [[String:AnyObject]]) -> [DTOJobList] {
        
        var dtoJobList = [DTOJobList]()
        
        for i in value {
         //   print(i)
            var address_street = ""
            var address_city = ""
            var address_state = ""
            var address_zip_code = 0
            var app_action = ""
            var approval_status = ""
            var created_date = ""
            var description = ""
            var due_date = ""
            var image_url_full = ""
            var image_url_medium = ""
            var image_url_small = ""
            var image_url_tiny = ""
            var image_url_tiny2 = ""
            var instructions_summary = ""
            var interior_access_needed = 0
            var lot_size_sq_ft = 0
            var priority = 0
            var status = ""
            var support_contact = ""
            var uri = ""
            var vendor_name = ""
            var won = ""
            var work_order_type = ""
            var work_ordered = ""
            var last_status_update:LastStatusUpdate?
            
            
            
            
            if let addressStreet = i["address_street"] as? String {
                address_street = addressStreet
            }
            if let addressCity = i["address_city"] as? String {
                address_city = addressCity
            }

            if let addressState = i["address_state"] as? String {
                address_state = addressState
            }
            if let addressZipCode = i["address_zip_code"] as? Int {
                address_zip_code = addressZipCode
            }
            if let appAction = i["app_action"] as? String {
                app_action = appAction
            }
            
            if let approvalStatus = i["approval_status"] as? String {
                approval_status = approvalStatus
            }
            if let appAction = i["app_action"] as? String {
                app_action = appAction
            }
            if let createddate = i["created_date"] as? String {
                created_date = createddate
            }
            if let desc = i["description"] as? String {
                description = desc
            }
            if let duedate = i["due_date"] as? String {
                due_date = duedate
            }
            if let imageurlfull = i["image_url_full"] as? String {
                image_url_full = imageurlfull
            }
            if let imageurlmedium = i["image_url_medium"] as? String {
                image_url_medium = imageurlmedium
            }
            if let imageurlsmall = i["image_url_small"] as? String {
                image_url_small = imageurlsmall
            }
            if let imageurltiny = i["image_url_tiny"] as? String {
                image_url_tiny = imageurltiny
            }
            if let imageurltiny2 = i["image_url_tiny2"] as? String {
                image_url_tiny2 = imageurltiny2
            }
            if let instructionssummary = i["instructions_summary"] as? String {
                instructions_summary = instructionssummary
            }
            if let interioraccessneeded = i["interior_access_needed"] as? Int {
                interior_access_needed = interioraccessneeded
            }
            if let lot_size_sqft = i["lot_size_sq_ft"] as? Int {
                lot_size_sq_ft = lot_size_sqft
            }
            if let prior = i["priority"] as? Int {
                priority = prior
            }
            if let interioraccessneeded = i["interior_access_needed"] as? Int {
                interior_access_needed = interioraccessneeded
            }
            if let statuss = i["status"] as? String {
                status = statuss
            }
            if let supportcontact = i["support_contact"] as? String {
                support_contact = supportcontact
            }
            if let urii = i["uri"] as? String {
                uri = urii
            }
            if let vendorname = i["vendor_name"] as? String {
                vendor_name = vendorname
            }
            if let wonn = i["won"] as? String {
                won = wonn
            }
            if let work_ordertype = i["work_order_type"] as? String {
                work_order_type = work_ordertype
            }
            if let workordered = i["work_ordered"] as? String {
                work_ordered = workordered
            }
            
            if let last_statusUpdate = i["last_status_update"] as? [String:Any] {
                
                var delay_reason = ""
                var explanation = ""
                var order_status = ""
                var won  = ""
                var expected_upload_date = ""
               
                
                if let delayreason = last_statusUpdate["delay_reason"] as? String {
                    delay_reason = delayreason
                }
                if let explan = last_statusUpdate["explanation"] as? String {
                    explanation = explan
                }
                if let orderstatus = last_statusUpdate["order_status"] as? String {
                    order_status = orderstatus
                }
                if let expected_uploadDate = last_statusUpdate["expected_upload_date"] as? String {
                    expected_upload_date = expected_uploadDate
                }
                if let wonn = i["won"] as? String {
                    won = wonn
                }
             last_status_update = LastStatusUpdate(delay_reason: delay_reason, expected_upload_date: expected_upload_date, explanation: explanation, order_status: order_status, won: won)
                 
            }
            
            let dtoJob = DTOJobList(address_street:address_street, address_city: address_city, address_state: address_state, address_zip_code: address_zip_code, app_action: app_action, approval_status: approval_status, created_date: created_date, description: description, due_date: due_date, image_url_full: image_url_full, image_url_medium: image_url_medium, image_url_small: image_url_small, image_url_tiny: image_url_tiny, image_url_tiny2: image_url_tiny2, instructions_summary: instructions_summary, interior_access_needed: interior_access_needed, lot_size_sq_ft: lot_size_sq_ft, priority: priority, status: status, support_contact: support_contact, uri: uri, vendor_name: vendor_name, won: won, work_order_type: work_order_type, work_ordered: work_ordered, last_status_update: last_status_update ?? nil)
            dtoJobList.append(dtoJob)
            
            
        }
        return dtoJobList
    }
    
    
    func getPhotos(byUserId userId: String, won: String, completion: @escaping ResponseJobPhotos) {
        
        let parameters: HTTPHeaders = ["X-USER-ID": userId,
                          "X-APP-ID": Config.appId,
                                "Content-Type": "application/json"
        ]
        let url = Config.shared.getPhotosURL + won + "/photo"
        AF.request(url, headers: parameters).responseJSON { response in
          //  debugPrint(response)

            switch response.result {
            case .success(let value):
                    
                    if let array = value as? [[String:String]] {
                        let dtoJobDetailList =  self.convertDATtoDTOPhotos(i: array)
                     completion(dtoJobDetailList,nil)
                    } else {
                     completion(nil,NSError() as Error)
                    }
                
                
                break
                
            case .failure(let error):
                print(error)
                 completion(nil ,NSError() as Error)
                break
                
            }
        }
    }
 
    
    func getJobDetail(byUserId userId: String, won: String, completion: @escaping ResponseJobDetail) {
        
        let parameters: HTTPHeaders = ["X-USER-ID": userId,
                          "X-APP-ID": Config.appId,
                                "Content-Type": "application/json"
        ]
        let url = Config.shared.jobDetailURL + won
        AF.request(url, headers: parameters).responseJSON { response in
          //  debugPrint(response)

            switch response.result {
            case .success(let value):
                    
                    if let array = value as? [String:AnyObject] {
                        let dtoJobDetailList =  self.convertDATtoDTOJobDetail(i: array)
                     completion(dtoJobDetailList,nil)
                    } else {
                     completion(nil,NSError() as Error)
                    }
                
                
                break
                
            case .failure(let error):
                print(error)
                 completion(nil ,NSError() as Error)
                break
                
            }
        }
    }
 
    
    func getJobs(byUserId userId: String, completion: @escaping ResponseJobList) {
        

        let parameters: HTTPHeaders = ["X-USER-ID": userId,
                          "X-APP-ID": Config.appId,
                                "Content-Type": "application/json"
        ]



        print(Config.shared.jobListURL)
        print(parameters)
        AF.request(Config.shared.jobListURL, headers: parameters).responseJSON { response in
          //  debugPrint(response)
            var dtoJobList = [DTOJobList]()

            switch response.result {
            case .success(let value):
                    
                    if let array = value as? [[String:AnyObject]] {
                     dtoJobList =  self.convertDATtoDTOJobList(value: array)
                     completion(dtoJobList,nil)
                    } else {
                     completion(nil,NSError() as Error)
                    }
                
                
                break
                
            case .failure(let error):
                print(error)
                 completion(nil ,NSError() as Error)
                break
                
            }
        }



     
       
        
        
    

            
    }
    




     
    
}
