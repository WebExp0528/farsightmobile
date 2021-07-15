//
//  DTOJobList.swift
//  Farsight App
//
//  Created by Hamza Malik on 15/07/2021.
//

import Foundation

struct DTOJobList {
    
    var address_street: String = ""
    var address_city : String = ""
    var  address_state :String = ""
    var  address_zip_code :Int = 0
    var  app_action :String = ""
    var  approval_status :String = ""
    var  created_date :String = ""
    var description : String = ""
    var due_date : String = ""
    var image_url_full : String = ""
    var image_url_medium : String = ""
    var image_url_small : String = ""
    var image_url_tiny : String = ""
    var image_url_tiny2 : String = ""
    var instructions_summary: String = ""
    var interior_access_needed: Int = 0
    var lot_size_sq_ft: Int = 0
    var priority: Int = 0
    var status: String = ""
    var support_contact: String = ""
    var uri: String = ""
    var vendor_name: String = ""
    var won: String = ""
    var work_order_type: String = ""
    var work_ordered: String = ""
    
    
    var last_status_update:LastStatusUpdate?
    
    
    
    
}

struct LastStatusUpdate {
    var delay_reason: String = ""
    var expected_upload_date: String = ""
    var explanation: String = ""
    var order_status: String = ""
    var won: String = ""
}
