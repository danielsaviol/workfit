//
//  CustomUIView.swift
//  WorkFit
//
//  Created by IFCE on 07/03/17.
//  Copyright © 2017 Work Fit Team. All rights reserved.
//

import UIKit

class CustomUIView: UIView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.init(red: 0x22/255, green: 0x26/255, blue: 0x31/255, alpha: 1.0)
    }
    
   /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
