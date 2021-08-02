//
//  FSDetailView.swift
//  Farsight App
//
//  Created by WebDEV on 7/23/21.
//

import UIKit

class FSBaseDetailView: UIView {

    var workOrderDetail : WorkOrderDetail? {
        didSet {
            onChangedDetail()
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func onChangedDetail () {
    }

}
