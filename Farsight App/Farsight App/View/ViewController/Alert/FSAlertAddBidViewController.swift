//
//  FSAlertAddBidViewController.swift
//  Farsight App
//
//  Created by WebDEV on 7/21/21.
//

import UIKit

class FSAlertAddBidViewController: FSBaseViewController {
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var unitTextField: UITextField!
    @IBOutlet weak var unitPriceTextField: UITextField!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    var onDimiss: ((BidModel?) -> ())?
    private let bid = BidModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalTransitionStyle = .crossDissolve
        setupUI()
    }

    @IBAction func onTapCloseButton(_ sender: UIButton) {
        self.dismiss(animated: false, completion: { [weak self] in
            guard let self = self else { return }
            self.onDimiss?(nil)
        })
    }
    
    @IBAction func onTapSendBidButton(_ sender: UIButton) {
        bid.title = titleTextField.text ?? ""
        self.dismiss(animated: false, completion: { [weak self] in
            guard let self = self else { return }
            self.onDimiss?(self.bid)
        })
    }
}

extension FSAlertAddBidViewController {
    static func show(currentVC: UIViewController,
                     onDimiss: ((BidModel?) -> ())?) {
        let viewC = FSAlertAddBidViewController.instantiate(fromAppStoryboard: .Alert)
        viewC.modalPresentationStyle = .overCurrentContext
        viewC.modalTransitionStyle = .crossDissolve
        viewC.providesPresentationContextTransitionStyle = true
        viewC.definesPresentationContext = true
        viewC.onDimiss = onDimiss
        currentVC.present(viewC, animated: true, completion: { })
    }
    
    private func setupUI() {
        quantityTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        unitPriceTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        bid.quantity = Int(quantityTextField.text ?? "0") ?? 0
        bid.unitPrice = Int(unitPriceTextField.text ?? "0") ?? 0
        let total = bid.quantity * bid.unitPrice
        totalPriceLabel.text = "$\(total) = \(bid.quantity)CY @ $\(bid.unitPrice) per CY"
    }
}
