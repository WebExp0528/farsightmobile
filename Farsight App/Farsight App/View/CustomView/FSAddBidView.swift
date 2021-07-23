//
//  FSAddBidView.swift
//  Farsight App
//
//  Created by WebDEV on 7/21/21.
//

import UIKit

class FSAddBidView: FSBaseDetailView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var bidTableView: UITableView!
    
    private var listBid = [BidModel]() {
        didSet {
            bidTableView.reloadData()
            let totalSum = listBid.map({ $0.quantity * $0.unitPrice }).reduce(0, +)
            totalLabel.text = "Total = $\(totalSum).00"

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
        Bundle.main.loadNibNamed("FSAddBidView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [ .flexibleHeight, .flexibleWidth]
        setupTb()
        guard let vc = UIApplication.getTopViewController() else { return }
        topVC = vc
    }

    
    @IBAction func onTapAddBidButton(_ sender: UIButton) {
        FSAlertAddBidViewController.show(currentVC: topVC, onDimiss: { [weak self] bid in
            guard let self = self else { return }
            guard let bid = bid else { return }
            self.listBid.append(bid)
        })
    }
    
    @IBAction func onTapFinishSubmitButton(_ sender: UIButton) {
    }
}

//MARK: - UI
extension FSAddBidView {
    private func setupTb() {
        bidTableView.register(UINib(nibName: "FSBidItemTableViewCell", bundle: nil), forCellReuseIdentifier: "FSBidItemTableViewCell")
        bidTableView.delegate = self
        bidTableView.dataSource = self
        bidTableView.tableFooterView = UIView()
        totalLabel.text = "Total = $0.00"
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension FSAddBidView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listBid.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FSBidItemTableViewCell", for: indexPath) as! FSBidItemTableViewCell
        cell.tag = indexPath.row
        cell.delegate = self
        cell.bid = listBid[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
}

//MARK: - FSBidItemTableViewCellDelegate
extension FSAddBidView: FSBidItemTableViewCellDelegate {
    func didTapCancelButton(with cell: FSBidItemTableViewCell) {
        listBid.remove(at: cell.tag)
    }
}
