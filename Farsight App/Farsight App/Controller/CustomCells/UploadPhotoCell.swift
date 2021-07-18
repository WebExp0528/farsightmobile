//
//  UploadPhotoCell.swift
//  Farsight App
//
//  Created by Hamza Malik on 17/07/2021.
//

import UIKit


class UploadPhotoCell: UITableViewCell,  UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var viewUploadButton: UIButton!
    
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var heightConstant: NSLayoutConstraint!
    
    @IBOutlet weak var collectionView: UICollectionView!
    var uploadHandler : (() -> ())?
    var viewUploadedPhotos : (() -> ())?
    var postedImages = [DTOPhotos]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "GalleryCell", bundle: nil), forCellWithReuseIdentifier: "GalleryCell")
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setup(canViewUploaded:Bool, photos:[DTOPhotos]) {
        
        self.postedImages = photos

        if (canViewUploaded) {
            
            self.viewUploadButton.setTitle("Hide Images", for: .normal)
            self.collectionView.isHidden = false
            self.heightConstant.constant = 430
            self.collectionView.reloadData()
            
        } else {
            
            self.viewUploadButton.setTitle("View \(self.postedImages.count) Uploaded Images", for: .normal)
            self.collectionView.isHidden = true
            self.heightConstant.constant = 130


        }
    }
    
    @IBAction func view(_ sender: Any) {
        
        if (self.postedImages.count > 0) {
            if let tapHandler = self.viewUploadedPhotos {
            tapHandler()
           }
            
        }
    }
    @IBAction func uploadBtnAction(_ sender: Any) {
        if let tapHandler = self.uploadHandler {
            tapHandler()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCell", for: indexPath) as! GalleryCell
        
        DispatchQueue.global(qos: .background).async {
            do
                {
                    let data = try Data.init(contentsOf: URL.init(string:self.postedImages[indexPath.row].image_url_full )!)
                    DispatchQueue.main.async {
                        let image: UIImage? = UIImage(data: data) ?? nil
                        if let img = image {
                            cell.Img.image = img
                        }
                    }
                }
            catch {
                // error
            }
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 4 - 1
        
        return CGSize(width: width, height: width)
    
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
}
