//
//  TxtFieldImg.swift
//  WorkFit
//
//  Created by IFCE on 23/02/17.
//
//

import UIKit

class TxtFieldImg: UITextField {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.borderWidth = 0
        self.backgroundColor = UIColor.clear
        self.textColor = UIColor.white
        let border = CALayer()
        let borderWidth = CGFloat(1.0)
        border.borderColor = UIColor.gray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - borderWidth, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        self.attributedPlaceholder = NSAttributedString(string:self.placeholder!,
                                                                 attributes:[NSForegroundColorAttributeName: UIColor.gray])
    }
    

    func editConfig(image: String, position: Bool){
        let imageView = UIImageView()
        let image = UIImage(named: image)
        
        imageView.image = image
        
        if position {
            self.leftViewMode = UITextFieldViewMode.always
            imageView.frame = CGRect(x: 20, y: 0, width: 17, height: 17)
            self.leftView = imageView
            
        } else {
            self.leftViewMode = UITextFieldViewMode.always
            imageView.frame = CGRect(x: 20, y: 0, width: 17, height: 17)
            self.rightView = imageView
        }
        
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
    
        let rect = CGRect(x: 8,y: 6,width: 17, height: 17)
        return rect
    }

    
}
