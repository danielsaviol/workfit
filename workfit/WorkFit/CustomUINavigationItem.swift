//
//  CustomUINavigationItem.swift
//  WorkFit
//
//  Created by IFCE on 07/03/17.
//  Copyright © 2017 Work Fit Team. All rights reserved.
//259bf3

import UIKit

class CustomUINavigationItem: UINavigationController {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.navigationBar.barTintColor = UIColor.init(red: 0x25/255, green: 0x9b/255, blue: 0xf3/255, alpha: 1.0)
        self.navigationBar.backItem?.title = " "
    }

}
