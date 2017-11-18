//
//  FoodCustomCell.swift
//  WorkFit
//
//  Created by Daniel on 01/03/17.
//  Copyright © 2017 Work Fit Team. All rights reserved.
//

import UIKit
import UICircularProgressRing

class FoodCustomCell: UITableViewCell {
    
    @IBOutlet weak var lbFood: UILabel!
    
    @IBOutlet weak var lbNum: UILabel!
    
    @IBOutlet weak var ringKcal: UICircularProgressRingView!
    
    @IBOutlet weak var ringProt: UICircularProgressRingView!

    @IBOutlet weak var ringFat: UICircularProgressRingView!
    
    @IBOutlet weak var ringCarb: UICircularProgressRingView!
    
    
}
