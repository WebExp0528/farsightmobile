//
//  JobDetailViewController.swift
//  Farsight App
//
//  Created by Hamza Malik on 17/07/2021.
//

import UIKit
import SVProgressHUD

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
    var won:String = ""
    private var mJobListPresenter: JobListPresenter!

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let uploadPhotoCell = tableView.dequeueReusableCell(withIdentifier: "UploadPhotoCell") as! UploadPhotoCell
        return uploadPhotoCell
    }
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.isScrollEnabled = false
        self.tableView.register(UINib(nibName: "UploadPhotoCell", bundle: nil), forCellReuseIdentifier: "UploadPhotoCell")
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 45.0
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        mJobListPresenter = JobListPresenter(withJobService: JobService(), jobListView: self)
        mJobListPresenter.getJobsDetail(userId: Config.userId, won: self.won)
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
