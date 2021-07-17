//
//  JobDetailViewController.swift
//  Farsight App
//
//  Created by Hamza Malik on 17/07/2021.
//

import UIKit

class JobDetailViewController: UIViewController,UITableViewDelegate,  UITableViewDataSource {
    
    @IBOutlet weak var mainImgView: UIImageView!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var dueDateLbl: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var serviceCallLbl: UILabel!
    @IBOutlet weak var woLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    
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

        self.tableView.register(UINib(nibName: "UploadPhotoCell", bundle: nil), forCellReuseIdentifier: "UploadPhotoCell")
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 45.0
        // Do any additional setup after loading the view.
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
