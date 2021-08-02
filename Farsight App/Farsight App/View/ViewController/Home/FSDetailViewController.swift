//
//  FSDetailViewController.swift
//  Farsight App
//
//  Created by WebDEV on 7/15/21.
//

import UIKit
import SDWebImage

//MARK: -Controller

class FSDetailViewController: FSBaseViewController {
    
    @IBOutlet weak var containerFunctionView: UIView!    
    @IBOutlet weak var actionView: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var actionMenuButton: UIButton!
    
    
    @IBOutlet weak var woImageView: UIImageView!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    //MARK: - var
    public var woId : String = "" {
        didSet {
            loadDetails()
        }
    }
    
    private var workOrderDetail : WorkOrderDetail?
    
    private var actionType : ActionItems = ActionItems.Instructions {
        didSet {
            setupContentView()
        }
    }

    private var isShowActionView = true {
        didSet {
            showActionView(with: isShowActionView)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Detail"
//        self.actionMenuButton = 
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        beforePhotoView.frame = containerPhotoView.frame
//        duringPhotoView.frame = containerPhotoView.frame
//        afterPhotoView.frame = containerPhotoView.frame
//        addBidView.frame = containerFunctionView.bounds
//        submitView.frame = containerFunctionView.bounds
    }
    
    @IBAction func onTapActionButton(_ sender: UIButton) {
        isShowActionView = !isShowActionView
    }
    
    @IBAction func onTapExpectOnTimeButton(_ sender: UIButton) {
        FSAlertUpdateViewController.show(currentVC: self, onDimiss: {
            
        })
    }
    
    @IBAction func onTapFunctionButton(_ sender: UIButton) {
        print(sender.tag)
        switch sender.tag {
        case ActionItems.BeforePhotos.tag:
            actionType = ActionItems.BeforePhotos
            break
        case ActionItems.DuringPhotos.tag:
            actionType = ActionItems.DuringPhotos
            break
        case ActionItems.AfterPhotos.tag:
            actionType = ActionItems.AfterPhotos
            break
//        case ActionItems.CompleteSurvey.tag:
//            containerPhotoView.isHidden = true
//            let vc = FSSurveyViewController.instantiate(fromAppStoryboard: .Other)
//            self.present(vc, animated: true, completion: nil)
        case ActionItems.CreateBid.tag:
            actionType = ActionItems.CreateBid
            break
        case ActionItems.CompleteSurvey.tag:
            actionType = ActionItems.CompleteSurvey
            break
        case ActionItems.Instructions.tag:
            actionType = ActionItems.Instructions
            break
        default:
            break
        }
    }
}

//MARK: -UI

extension FSDetailViewController {
    private func setupDetails(data : WorkOrderDetail?){
        if data == nil {
            return
        }
        self.workOrderDetail = data
        
        self.woImageView.sd_setImage(with: URL(string: workOrderDetail?.image_url_full ?? ""))
        self.nameLabel.text = workOrderDetail?.work_ordered
        self.addressLabel.text = "\(workOrderDetail?.address_street ?? ""), \(workOrderDetail?.address_city ?? ""), \(workOrderDetail?.address_state ?? "")"
        
        
        self.idLabel.text = "WO #\(workOrderDetail?.won ?? "")"
        self.dueDateLabel.text = " Due: \(workOrderDetail?.due_date ?? "") "
        self.statusLabel.text = ""
        let date = workOrderDetail?.due_date?.toDate(withFormat: "MMM d, yyyy")
        if (date != nil) {
            let status = statusFromDate(date: date!)
            self.statusLabel.text = " \(status.label) "
            self.statusLabel.backgroundColor = status.color
        }
        
        setupContentView()
    }
    
    private func setupContentView() {
        let subView = actionType.view
        subView.removeFromSuperview()
        subView.workOrderDetail = self.workOrderDetail
        containerFunctionView.addSubview(subView)
        subView.frame = containerFunctionView.bounds
        
        subView.translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint = NSLayoutConstraint(item: subView, attribute: .leading, relatedBy: .equal, toItem: containerFunctionView, attribute: .leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: subView, attribute: .trailing, relatedBy: .equal, toItem: containerFunctionView, attribute: .trailing, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: subView, attribute: .top, relatedBy: .equal, toItem: containerFunctionView, attribute: .top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: subView, attribute: .bottom, relatedBy: .equal, toItem: containerFunctionView, attribute: .bottom, multiplier: 1, constant: -5)

        containerFunctionView.addConstraints([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
        containerFunctionView.layoutIfNeeded()
    }
    
    private func showActionView(with isShow: Bool) {
        let bottomSpacing: CGFloat = isShow ? 0 : -160
        UIView.animate(withDuration: 0.6) {
            self.bottomConstraint.constant = bottomSpacing
            self.view.layoutIfNeeded()
        }
    }
    
    private func loadDetails() {
        print("Loading Details")
        if woId != "" {
            APIManager.shared().call(type: EndpointItem.getWorkOrderDetail(self.woId), progress: true) { (data:WorkOrderDetail?, error) in
                self.setupDetails(data: data ?? nil)
            }
        }
    }
}
