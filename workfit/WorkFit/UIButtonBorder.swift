//
//  UIButtonBorder.swift
//  Pods
//
//  Created by IFCE on 23/02/17.
//
//

import UIKit

class UIButtonBorder: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.white.cgColor
    }
    
//    func animate(btn: UIButtonBorder){
//        UIView.animate(withDuration: 0.05, animations: {
//            btn.transform = CGAffineTransform.identity.scaledBy(x: 0.8, y: 0.8)
//        }, completion: { (finish) in
//            UIView.animate(withDuration: 0.05, animations: {
//                btn.transform = CGAffineTransform.identity
//            })
//        })
//    }
}
