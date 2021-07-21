//
//  UploadPhotoCell.swift
//  Farsight App
//
//  Created by WebDEV on 7/21/2021.
//

import UIKit


class SubmitCell: UITableViewCell {

   
    @IBOutlet weak var noOfSelectedPhotos: UILabel!
    
    @IBOutlet weak var uploadButton: UIButton!
    
    var uploadHandler : (() -> ())?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   
  
    @IBAction func uploadBtnAction(_ sender: Any) {
        if let tapHandler = self.uploadHandler {
            tapHandler()
        }
    }
    
    
}
