//
//  FSBidItemTableViewCell.swift
//  Farsight App
//
//  Created by WebDEV on 7/21/21.
//

import UIKit

protocol FSBidItemTableViewCellDelegate: AnyObject {
    func didTapCancelButton(with cell: FSBidItemTableViewCell)
}

class FSBidItemTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    
    weak var delegate: FSBidItemTableViewCellDelegate?
    var bid = BidModel() {
        didSet {
            updateUI(with: bid)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onTapCancelButton(_ sender: UIButton) {
        delegate?.didTapCancelButton(with: self)
    }
    
    
    private func updateUI(with bid: BidModel) {
        titleLabel.text = bid.title
        let total = bid.quantity * bid.unitPrice
        totalLabel.text = "$\(total) = \(bid.quantity)CY @ $\(bid.unitPrice) per CY"
    }
}
