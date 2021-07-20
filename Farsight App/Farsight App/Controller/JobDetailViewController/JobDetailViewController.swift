//
//  JobDetailViewController.swift
//  Farsight App
//
//  Created by Hamza Malik on 17/07/2021.
//

import UIKit
import SVProgressHUD
import YPImagePicker
class JobDetailViewController: UIViewController,UITableViewDelegate,  UITableViewDataSource, IJobListView {
    
    @IBOutlet weak var mainImgView: UIImageView!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var dueDateLbl: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var serviceCallLbl: UILabel!
    @IBOutlet weak var woLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    var jobDetail: DTOJobDetail?
    var dtoPhotos: [DTOPhotos] = []
    var photos: [YPMediaItem] = []
    var mIsPhotoCell = false
    var uploaded = 0
    var won:String = ""
    var viewUploadedPhotos = false
    
    private var mJobListPresenter: JobListPresenter!
    var config = YPImagePickerConfiguration()
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func uploadPhotos() {
        for item in self.photos {
        switch item {
        case .photo(let photo):
            

            let param = [
                
                "evidenceType": "photo",
                "fileExt":"jpg",
                "fileName":"Test",
                "fileType": "picture",
                "timestamp":"null",
                "gpsAccuracy":"null",
                "gpsLatitude":"null",
                "gpsLongitude":"null",
                "gpsTimestamp":"null",
                "parentUuid":"null",
                "uuid":UUID().uuidString,
                "imageLabel":"Before",
                "file": self.convertImageToBase64(image: photo.image)
                
            ]
            self.mJobListPresenter.uploadPhotos(userId: Config.userId, won: self.won, params: param)

            
        case .video(let video):
            print(video)
        }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (self.mIsPhotoCell && !self.photos.isEmpty) {
            let submitPhotoCell = tableView.dequeueReusableCell(withIdentifier: "SubmitCell") as! SubmitCell
            submitPhotoCell.noOfSelectedPhotos.text = "You have selected \(photos.count) files"
            return submitPhotoCell
            
        }
        
        
        let uploadPhotoCell = tableView.dequeueReusableCell(withIdentifier: "UploadPhotoCell") as! UploadPhotoCell
        uploadPhotoCell.setup(canViewUploaded: self.viewUploadedPhotos, photos: self.dtoPhotos)
        self.photos.removeAll()
        self.mIsPhotoCell = false
        uploadPhotoCell.viewUploadedPhotos = {
            if (self.viewUploadedPhotos) {
                self.viewUploadedPhotos = false

            } else {
                self.viewUploadedPhotos = true
                
            }
            self.tableView.reloadData()
        }
        uploadPhotoCell.uploadHandler = {
            let picker = YPImagePicker(configuration: self.config)
            picker.didFinishPicking { [unowned picker] items, cancelled in
                if (!cancelled) {
                    self.photos.removeAll()
                    self.photos = items
                    self.mIsPhotoCell = true
                    self.tableView.reloadData()
                }
                picker.dismiss(animated: true, completion: nil)
            }
            self.present(picker, animated: true, completion: nil)

        }
        return uploadPhotoCell
    }
    func convertImageToBase64(image: UIImage) -> String {
           let imageData: Data? = image.jpegData(compressionQuality: 0.4)

          // let imageData = image.pngData()!
           
           return imageData!.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
       
        
        self.tableView.isScrollEnabled = false
        self.tableView.register(UINib(nibName: "UploadPhotoCell", bundle: nil), forCellReuseIdentifier: "UploadPhotoCell")
        self.tableView.register(UINib(nibName: "SubmitCell", bundle: nil), forCellReuseIdentifier: "SubmitCell")

        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 500
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        mJobListPresenter = JobListPresenter(withJobService: JobService(), jobListView: self)
        mJobListPresenter.getJobsDetail(userId: Config.userId, won: self.won)
        mJobListPresenter.getPhotos(userId: Config.userId, won: self.won)

    }

    func showLoader() {
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setDefaultMaskType(.custom)
        SVProgressHUD.setForegroundColor(UIColor.darkGray)           //Ring Color
        SVProgressHUD.setBackgroundColor(UIColor.gray)        //HUD Color
        SVProgressHUD.setBackgroundLayerColor(UIColor.clear)    //Background Color
        SVProgressHUD.show()
        
    }
    func statusFromDate(date:Date) ->String {
        let currentDate = Date()

        if (date > currentDate) {
            return "On Time"
        } else if (date < currentDate) {
            return "Past Due"
        } else if (date == currentDate) {
            return "Due Today"
        }
        return ""
    }
    
    func hideLoader() {
        SVProgressHUD.dismiss()
    }
    
    func showJobsList(dtoJobs: [DTOJobList]?) {
       
    }
    func showJobsPhotos(dtoPhotos: [DTOPhotos]?) {
         
        if let photos = dtoPhotos {
            self.uploaded = photos.count
            self.dtoPhotos = photos
        }
        self.tableView.reloadData()
    }
    
    func showJobsDetail(dtoDetail: DTOJobDetail?) {
        DispatchQueue.main.async {
            
            self.jobDetail = nil
            if let dtoJobDetail = dtoDetail {
                self.jobDetail = dtoJobDetail
                let date = self.jobDetail?.due_date.toDate(withFormat: "MMM d, yyyy")
                if let date = date {
                    
                    self.status.text = self.statusFromDate(date: date)
                    self.dueDateLbl.text = self.jobDetail?.due_date
                } else {
                    
                    self.status.text = ""
                    self.dueDateLbl.text = ""
                }
            
                self.woLbl.text = "WO #\(self.jobDetail?.won ?? "")"
                self.addressLbl.text = (self.jobDetail?.address_street ?? "") + " " + (self.jobDetail?.address_city ?? "")
                self.cityLbl.text = (self.jobDetail?.address_state ?? "") + " " + (self.jobDetail?.address_zip_code ?? "")
              
                DispatchQueue.global(qos: .background).async {
                    do
                        {
                            let data = try Data.init(contentsOf: URL.init(string:self.jobDetail?.image_url_full ?? "")!)
                            DispatchQueue.main.async {
                                let image: UIImage? = UIImage(data: data) ?? nil
                                if let img = image {
                                    self.mainImgView.image = img
                                }
                            }
                        }
                    catch {
                        // error
                    }
                }
            }
            
            self.tableView.reloadData()
            
        }
        
    }
    
    func showErrorMessage(msg: String) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
