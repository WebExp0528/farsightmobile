//
//  FSAlertUpdateViewController.swift
//  Farsight App
//
//  Created by WebDEV on 7/21/21.
//

import UIKit

final class FSAlertUpdateViewController: FSBaseViewController {

    @IBOutlet weak var closeButton: UIButton!
    
    var onDimiss: (()->Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalTransitionStyle = .crossDissolve
    }
    
    @IBAction func onTapCloseButton(_ sender: UIButton) {
        self.dismiss(animated: false, completion: onDimiss)
    }
}

extension FSAlertUpdateViewController {
    static func show(currentVC: UIViewController,
                     onDimiss: (() -> Void)?) {
        let viewC = FSAlertUpdateViewController.instantiate(fromAppStoryboard: .Alert)
        viewC.modalPresentationStyle = .overCurrentContext
        viewC.modalTransitionStyle = .crossDissolve
        viewC.providesPresentationContextTransitionStyle = true
        viewC.definesPresentationContext = true
//        viewC.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        viewC.onDimiss = onDimiss
        currentVC.present(viewC, animated: true, completion: { })
    }
}
