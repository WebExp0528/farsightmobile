//
//  FSAlertSubmitViewController.swift
//  Farsight App
//
//  Created by WebDEV on 7/21/21.
//

import UIKit

class FSAlertSubmitViewController: FSBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalTransitionStyle = .crossDissolve
    }
}

extension FSAlertSubmitViewController {
    static func show(currentVC: UIViewController,
                     onDimiss: (() -> Void)?) {
        let viewC = FSAlertSubmitViewController.instantiate(fromAppStoryboard: .Alert)
        viewC.modalPresentationStyle = .overCurrentContext
        viewC.modalTransitionStyle = .crossDissolve
        viewC.providesPresentationContextTransitionStyle = true
        viewC.definesPresentationContext = true
//        viewC.onDimiss = onDimiss
        currentVC.present(viewC, animated: true, completion: { })
    }
}
