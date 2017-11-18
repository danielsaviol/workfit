//
//  UIButtonRounded.swift
//  Pods
//
//  Created by IFCE on 23/02/17.
//
//

import UIKit

class UIButtonRounded: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 2
        self.backgroundColor = UIColor.init(red: 0x25/255, green: 0x9b/255, blue: 0xf3/255, alpha: 1.0)
        
//        UIView.animate(withDuration: 0.05, animations: {
//            self.transform = CGAffineTransform.identity.scaledBy(x: 0.8, y: 0.8)
//        }, completion: { (finish) in
//            UIView.animate(withDuration: 0.05, animations: {
//                self.transform = CGAffineTransform.identity
//            })
//        })

    }

}
