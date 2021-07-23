//
//  FSHomeTableViewCell.swift
//  Farsight App
//
//  Created by WebDEV on 7/21/21.
//

import UIKit
import SDWebImage

class FSHomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var woImageView: UIImageView!
    @IBOutlet weak var updateStatusBtn: UIButton!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var woIdLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setWorkOrder(data: WorkOrder){
        self.woImageView.sd_setImage(with: URL(string: data.image_url_small ?? ""))
        self.nameLabel.text = data.work_ordered
        self.addressLabel.text = "\(data.address_street ?? ""), \(data.address_city ?? ""), \(data.address_state ?? "")"
        self.descLabel.text = data.description
        
        self.woIdLabel.text = "WorkOrder #\(data.won ?? "")"
        self.dueDateLabel.text = " Due: \(data.due_date ?? "") "
        self.statusLabel.text = ""
        let date = data.due_date?.toDate(withFormat: "MMM d, yyyy")
        if (date != nil) {
            let status = statusFromDate(date: date!)
            self.statusLabel.text = " \(status.label) "
            self.statusLabel.backgroundColor = status.color
        }
        
    }
}
