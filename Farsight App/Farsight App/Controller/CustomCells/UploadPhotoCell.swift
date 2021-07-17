//
//  UploadPhotoCell.swift
//  Farsight App
//
//  Created by Hamza Malik on 17/07/2021.
//

import UIKit

class UploadPhotoCell: UITableViewCell {

    @IBOutlet weak var viewUploadButton: UIButton!
    
    @IBOutlet weak var uploadButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func uploadBtnAction(_ sender: Any) {
        
    }
}
