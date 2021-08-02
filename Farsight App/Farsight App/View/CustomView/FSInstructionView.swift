//
//  FSInstructionView.swift
//  Farsight App
//
//  Created by WebDEV on 7/22/21.
//

import UIKit

class FSInstructionView: FSBaseDetailView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var instructionsTextView: UITextView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }

    private func customInit() {
        Bundle.main.loadNibNamed("FSInstructionView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [ .flexibleHeight, .flexibleWidth]
    }
    
    override func onChangedDetail() {
        
        let attributedText = NSMutableAttributedString()
        for instruction in self.workOrderDetail?.instructions_full ?? [] {
            let headerAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
            let header = NSAttributedString(string: "\(instruction.type ?? "") \n\n", attributes: headerAttributes)
            
            let bodyAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]
            let body = NSAttributedString(string: "\(instruction.instruction ?? "") \n\n", attributes: bodyAttributes)
            attributedText.append(header)
            attributedText.append(body)
            
        }
        
        self.instructionsTextView.attributedText = attributedText
    }
}
