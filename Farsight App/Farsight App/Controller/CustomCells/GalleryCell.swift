//
//  GalleryCell.swift
//  Farsight App
//
//  Created by WebDEV on 7/20/21.
//

import UIKit

class GalleryCell: UICollectionViewCell {

    @IBOutlet weak var Img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        Img.borderWidthh = 2
        Img.borderColorr = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }

}
