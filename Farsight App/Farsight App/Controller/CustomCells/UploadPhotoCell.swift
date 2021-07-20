//
//  UploadPhotoCell.swift
//  Farsight App
//
//  Created by WebDEV on 7/20/21.
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
    var noOfPage = 0
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
    
    func getPageItems(page: UInt, allItems: [DTOPhotos], maxItemsPerPage: UInt) -> [DTOPhotos] {
        let startIndex = Int(page * maxItemsPerPage)
        var length = max(0, allItems.count - startIndex)
        length = min(Int(maxItemsPerPage), length)

        guard length > 0 else { return [] }

        return Array(allItems[startIndex..<(startIndex + length)])
    }
    func setup(canViewUploaded:Bool, photos:[DTOPhotos]) {
        
       
        self.noOfPage = Int(ceil(Double(Float(photos.count)/20.0)))
        print("Number of pages", self.noOfPage)
        
        self.postedImages = self.getPageItems(page:0, allItems: photos, maxItemsPerPage: 20)

        if (canViewUploaded) {
            
            self.viewUploadButton.setTitle("Hide Images", for: .normal)
            self.collectionView.isHidden = false
            self.heightConstant.constant = 430
            self.collectionView.reloadData()
            
        } else {
            
            self.viewUploadButton.setTitle("View \(photos.count) Uploaded Images", for: .normal)
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
        let width = collectionView.frame.width / 3 - 1
        
        return CGSize(width: width, height: width)
    
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
}
