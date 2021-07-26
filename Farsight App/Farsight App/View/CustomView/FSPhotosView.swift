//
//  FSPhotosView.swift
//  Farsight App
//
//  Created by WebDEV on 7/21/21.
//

import UIKit
import Photos
import YPImagePicker
import SDWebImage
import SwiftyJSON
import Alamofire


class FSPhotosView: FSBaseDetailView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var photoCollection: UICollectionView!
    @IBOutlet weak var uploadPhotoButton: UIButton!
    @IBOutlet weak var infoLabel: UILabel!
    
    var config = YPImagePickerConfiguration()
    
    private var seletedImages : [YPMediaItem] = [] {
        didSet{
            onSelectedImages()
        }
    }
    
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
        
        
        config.isScrollToChangeModesEnabled = true
        config.onlySquareImagesFromCamera = true
        config.usesFrontCamera = false
        config.showsPhotoFilters = false
        config.showsVideoTrimmer = false
        config.shouldSaveNewPicturesToAlbum = true
        config.albumName = "DefaultYPImagePickerAlbumName"
        config.startOnScreen = YPPickerScreen.photo
        config.screens = [.library, .photo]
        config.showsCrop = .none
        config.targetImageSize = YPImageSize.original
        config.overlayView = UIView()
        config.hidesStatusBar = true
        config.hidesBottomBar = false
        config.hidesCancelButton = false
        config.library.options = nil
        config.library.onlySquare = false
        config.library.isSquareByDefault = true
        config.library.minWidthForItem = nil
        config.library.mediaType = YPlibraryMediaType.photo
        config.library.defaultMultipleSelection = true
        config.library.maxNumberOfItems = 10
        config.library.minNumberOfItems = 1
        config.library.numberOfItemsInRow = 4
        config.library.spacingBetweenItems = 1.0
        config.library.skipSelectionsGallery = false
        config.library.preselectedItems = nil
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
        guard let vc = UIApplication.getTopViewController() else { return }
        topVC = vc
        let picker = YPImagePicker(configuration: self.config)
        picker.didFinishPicking { [unowned picker] items, cancelled in
            if (!cancelled) {
                self.seletedImages = items
            }
            picker.dismiss(animated: true, completion: nil)
        }
        topVC.present(picker, animated: true, completion: nil)
    }
}

//MARK: - UI
extension FSPhotosView {
    private func updateUIWithArrPhoto() {
        photoCollection.isHidden = listImage.count == 0
        infoLabel.isHidden = listImage.count > 0
        photoCollection.reloadData()
    }
    
    private func onChangedCategory() {
        self.titleLabel.text = "\(self.category.id.capitalized) Photos"
        self.topView.backgroundColor = self.category.color
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
    
    func onSelectedImages() {
        print("Seleted Images")
        
        for item in self.seletedImages {
            switch item {
            case .photo(let photo):
//                let param = [
//                    "evidenceType": "photo",
//                    "fileExt":"jpeg",
//                    "fileName":"Test",
//                    "fileType": "picture",
//                    "timestamp":"null",
//                    "gpsAccuracy":"null",
//                    "gpsLatitude":"null",
//                    "gpsLongitude":"null",
//                    "gpsTimestamp":"null",
//                    "parentUuid":"null",
//                    "uuid":UUID().uuidString,
//                    "imageLabel": self.category.id,
//                    "file": self.convertImageToBase64(image: photo.image)
//                ] as [String : Any]
                
                let multipartFormData = MultipartFormData()
                multipartFormData.append("photo".data(using: .utf8, allowLossyConversion: false)!, withName: "evidenceType")
                multipartFormData.append("jpeg".data(using: .utf8, allowLossyConversion: false)!, withName: "fileExt")
                multipartFormData.append("Test".data(using: .utf8, allowLossyConversion: false)!, withName: "fileName")
                multipartFormData.append("picture".data(using: .utf8, allowLossyConversion: false)!, withName: "fileType")
                multipartFormData.append("null".data(using: .utf8, allowLossyConversion: false)!, withName: "timestamp")
                multipartFormData.append("null".data(using: .utf8, allowLossyConversion: false)!, withName: "gpsAccuracy")
                multipartFormData.append("null".data(using: .utf8, allowLossyConversion: false)!, withName: "gpsLatitude")
                multipartFormData.append("null".data(using: .utf8, allowLossyConversion: false)!, withName: "gpsLongitude")
                multipartFormData.append("null".data(using: .utf8, allowLossyConversion: false)!, withName: "gpsTimestamp")
                multipartFormData.append("null".data(using: .utf8, allowLossyConversion: false)!, withName: "parentUuid")
                multipartFormData.append(UUID().uuidString.data(using: .utf8, allowLossyConversion: false)!, withName: "uuid")
                multipartFormData.append(self.category.id.data(using: .utf8, allowLossyConversion: false)!, withName: "imageLabel")
                multipartFormData.append(self.convertImageToBase64(image: photo.image)!, withName: "file")
                
                print(multipartFormData)
                
                APIManager.shared().uploadPhoto(type: EndpointItem.uploadPhoto((self.workOrderDetail?.won)!), multipart: multipartFormData){(data:JSON?, error) in
                    print("Ended upload \(data) \(error)")
                }
                break
            case .video(v: _):
                break
            }
        }
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
        return CGSize(width: 100, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func convertImageToBase64(image: UIImage) -> Data? {
        let imageData: Data? = image.jpegData(compressionQuality: 0.4)
        // let imageData = image.pngData()!
//        let imageDataURI = imageData!.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
//        print("Converted image data => \(imageDataURI)")
        return imageData
    }
}
