//
//  FSAddBidViewController.swift
//  Farsight App
//
//  Created by WebDEV on 7/21/21.
//

import UIKit

class FSAddBidViewController: FSBaseViewController {
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var bidTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTb()
    }
    
    @IBAction func onTapDoneButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: {
            
        })
    }
    
    @IBAction func onTapAddBidButton(_ sender: UIButton) {
        FSAlertAddBidViewController.show(currentVC: self, onDimiss: { bid in
            
        })
    }
    
    @IBAction func onTapFinishSubmitButton(_ sender: UIButton) {
    }
}

//MARK: - UI
extension FSAddBidViewController {
    private func setupTb() {
        bidTableView.register(UINib(nibName: "FSBidItemTableViewCell", bundle: nil), forCellReuseIdentifier: "FSBidItemTableViewCell")
        bidTableView.delegate = self
        bidTableView.dataSource = self
        bidTableView.tableFooterView = UIView()
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension FSAddBidViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FSBidItemTableViewCell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
}
