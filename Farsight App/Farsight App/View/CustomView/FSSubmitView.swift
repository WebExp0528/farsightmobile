//
//  FSSubmitView.swift
//  Farsight App
//
//  Created by WebDEV on 7/21/21.
//

import UIKit

class FSSubmitView: FSBaseDetailView {

    @IBOutlet var contentView: UIView!
    
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
        print("setup submit view")
        Bundle.main.loadNibNamed("FSSubmitView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        print(self.bounds)
        contentView.autoresizingMask = [ .flexibleHeight, .flexibleWidth]
        guard let vc = UIApplication.getTopViewController() else { return }
        topVC = vc
    }

}
