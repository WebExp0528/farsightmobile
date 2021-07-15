//
//  ViewController.swift
//  Farsight App
//
//  Created by WebDEV on 7/12/21.
//

import UIKit
import SVProgressHUD
class JobListCell: UITableViewCell {
    
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var workOrderedLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var wonLbl: UILabel!
    @IBOutlet weak var dueDateLbl: UILabel!
    @IBOutlet weak var PastDue: UILabel!


    @IBOutlet weak var img: UIImageView!
    
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, IJobListView {
    
    
    @IBOutlet weak var tableView: UITableView!
    private var mJobListPresenter: JobListPresenter!
    private var mJobsList = [DTOJobList]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 400
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = #colorLiteral(red: 0.6704089046, green: 0.6745685935, blue: 0.6744734645, alpha: 1)
        mJobListPresenter = JobListPresenter(withJobService: JobService(), jobListView: self)
        mJobListPresenter.getJobsList(userId:Config.userId)
        // Do any additional setup after loading the view.
    }
    
    func status(date: Date) {
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mJobsList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jobListCell") as! JobListCell
        
        
        cell.descriptionLbl.text = ""
        cell.wonLbl.text = "WorkOrder#\(self.mJobsList[indexPath.row].won)"
        cell.addressLbl.text =  self.mJobsList[indexPath.row].address_street
        cell.cityLbl.text =  self.mJobsList[indexPath.row].address_city + self.mJobsList[indexPath.row].address_state
        cell.workOrderedLbl.text = self.mJobsList[indexPath.row].work_ordered
        
        let date = self.mJobsList[indexPath.row].due_date.toDate(withFormat: "MMM d, yyyy")
        if let date = date {
        cell.PastDue.text = self.statusFromDate(date: date)
        cell.dueDateLbl.text = "\(date)"
        } else {
        cell.PastDue.text = ""
        cell.dueDateLbl.text = ""
        }
        DispatchQueue.global(qos: .background).async {
            do
                {
                    let data = try Data.init(contentsOf: URL.init(string:self.mJobsList[indexPath.row].image_url_small)!)
                    DispatchQueue.main.async {
                        let image: UIImage? = UIImage(data: data) ?? nil
                        if let img = image {
                            cell.img.image = img
                        }
                    }
                }
            catch {
                // error
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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
        DispatchQueue.main.async {
            
            self.mJobsList.removeAll()
            if let dtoJobsList = dtoJobs {
                self.mJobsList = dtoJobsList
            }
            self.tableView.reloadData()
        }
    }
    
    func showErrorMessage(msg: String) {
        
    }
    
    
}

