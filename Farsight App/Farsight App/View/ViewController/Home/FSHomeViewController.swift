//
//  FSHomeViewController.swift
//  Farsight App
//
//  Created by WebDEV on 7/12/21.
//

import UIKit

class FSHomeViewController: FSBaseViewController {
    var workOrders: [WorkOrder]?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var descLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        APIManager.shared().call(type: EndpointItem.getWorkOrderList, progress: true) { (data:[WorkOrder]?, error) in
            self.workOrders = data
            self.reloadData()
        }
    }
}

//MARK: - UI
extension FSHomeViewController {
    private func setupTableView() {
        tableView.register(UINib(nibName: "FSHomeTableViewCell", bundle: nil), forCellReuseIdentifier: "FSHomeTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    private func reloadData(){
        self.tableView.reloadData()
        
        let name = self.workOrders?[0].vendor_name ?? ""
        self.descLabel.text = "Hello \(name), You are viewing \(self.workOrders?.count ?? 0) of \(self.workOrders?.count ?? 0) open work orders."
    }

}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension FSHomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.workOrders?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FSHomeTableViewCell", for: indexPath) as! FSHomeTableViewCell
        cell.setWorkOrder(data: self.workOrders![indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 144
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = FSDetailViewController.instantiate(fromAppStoryboard: .Main)
        vc.woId = self.workOrders![indexPath.row].won!
        navigationController?.pushViewController(vc, animated: true)
    }
}
