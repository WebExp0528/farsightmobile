//
//  WorkOrder.swift
//  Farsight App
//
//  Created by WebDEV on 7/22/21.
//

import Foundation

struct WorkOrder : Codable {
    let address_street: String?
    let address_city : String?
    let address_state : String?
    let address_zip_code : String?
    let app_action : String?
    let approval_status : String?
    let created_date : String?
    let description : String?
    let due_date : String?
    let image_url_full : String?
    let image_url_medium : String?
    let image_url_small : String?
    let image_url_tiny : String?
    let image_url_tiny2 : String?
    let instructions_summary : String?
    let interior_access_needed : Bool?
    let lot_size_sq_ft : Int?
    let priority : Int?
    let status : String?
    let support_contact : String?
    let uri : String?
    let vendor_name : String?
    let won : String?
    let work_order_type : String?
    let work_ordered : String?
    let last_status_update : LastStatusUpdate?
}

struct LastStatusUpdate : Codable {
    let delay_reason : String?
    let expected_upload_date : String?
    let explanation : String?
    let order_status : String?
    let won : String?
}
