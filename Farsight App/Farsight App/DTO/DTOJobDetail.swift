//
//  DTOJobDetail.swift
//  Farsight App
//
//  Created by WebDEV on 7/20/21.
//

import Foundation

struct DTOJobDetail {
    
    var api_user: String = ""
    var vendor_name : String = ""
    var support_contact: String = ""
    var won: String = ""
    var uri: String = ""
    var due_date: String =  ""
    var created_date: String =  ""
    var address_street:String = ""
    var address_city: String = ""
    var address_state:String = ""
    var address_zip_code:String = ""
    var gps_latitude:String = ""
    var gps_longitude: String = ""
    var image_url_tiny2:String = ""
    var image_url_tiny:String = ""
    var image_url_small:String = ""
    var image_url_medium:String = ""
    var image_url_full: String = ""
    var interior_access_needed: Bool = false
    var lot_size_sq_ft:Int = 0
    var priority: Int = 0
    var work_order_type:String = ""
    var work_ordered: String = ""
    var app_action: String = ""
    var source_won: String = ""
    var status: String = ""
    var instructions_full = [InstructionsFull]()
    var last_status_update: LastStatusUpdate?

}
struct InstructionsFull {
    var type: String = ""
    var action: String = ""
    var instruction: String = ""
}
