//
//  FSPhotosView.swift
//  Farsight App
//
//  Created by WebDEV on 7/21/21.
//

import UIKit
import Photos
import BSImagePicker
import SDWebImage

class FSPhotosView: FSBaseDetailView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var photoCollection: UICollectionView!
    @IBOutlet weak var uploadPhotoButton: UIButton!
    @IBOutlet weak var infoLabel: UILabel!
    
    private var listImage : [String] = [] {
        didSet {
           updateUIWithArrPhoto()
        }
    }
    
    var category : Category = Category.Before {
        didSet {
            onChangedCategory()
        }
    }
    
    private var imagePicker = ImagePickerController()
    private var topVC = UIViewController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }

    func customInit() {
        Bundle.main.loadNibNamed("FSPhotosView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [ .flexibleHeight, .flexibleWidth]
        setupCollectionView()
    }
    
    override func onChangedDetail() {
        print("Loading \(self.category.id) Photos")
        if self.workOrderDetail?.won != "" {
            APIManager.shared().call(type: EndpointItem.getWorkOrderPhotos((self.workOrderDetail?.won)!), progress: true) { (data:[WorkOrderPhoto]?, error) in
                self.listImage = data?.filter({ photo in
                    return photo.label == self.category.id
                }).map({ photo in
                    return photo.image_url_full
                }) as! [String]
                
            }
        }
    }
    
    @IBAction func onTapUploadPhotoButton(_ sender: UIButton) {
        print("Clicked upload button")
        
    }
}

//MARK: - UI
extension FSPhotosView {
    private func updateUIWithArrPhoto() {
        photoCollection.isHidden = listImage.count == 0
        infoLabel.isHidden = listImage.count > 0
        photoCollection.reloadData()
//        switch category {
//        case , .AfterPhotos:
//            skipButton.isHidden = listImage.count == 0
//            let title = listImage.count == 0 ? "Upload Photo" : "Upload More Photos"
//            uploadPhotoButton.setTitle(title, for: .normal)
//        case .DuringPhotos:
//            skipButton.isHidden = false
//        default:
//            break
//        }
    }
    
    private func onChangedCategory() {
        self.titleLabel.text = "\(self.category.id.capitalized) Photos"
    }
    
    private func getAssetThumbnail(asset: PHAsset) -> UIImage? {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail: UIImage?
        option.isSynchronous = true
        manager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
            thumbnail = result
        })
        return thumbnail
    }
    
    private func setupCollectionView() {
        photoCollection.register(UINib(nibName: "FSPhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FSPhotoCollectionViewCell")
        photoCollection.delegate = self
        photoCollection.dataSource = self
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension FSPhotosView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FSPhotoCollectionViewCell", for: indexPath) as! FSPhotoCollectionViewCell
        cell.imageView.sd_setImage(with:  URL(string: self.listImage[indexPath.row]))
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension FSPhotosView : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}
