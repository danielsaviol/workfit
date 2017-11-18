//
//  CoachCustomTableViewCell.swift
//  WorkFit
//
//  Created by IFCE on 06/03/17.
//  Copyright © 2017 Work Fit Team. All rights reserved.
//

import UIKit

class CoachCustomTableViewCell: UITableViewCell {


    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var labelCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func roundImage() {
        self.imageCell.layer.cornerRadius = self.imageCell.frame.size.height/2
        self.imageCell.clipsToBounds = true
    }
    
    func setCoach(strImage: String, str: String){
       imageCell.loadImageUsingCacheWithUrlString(strImage)
       labelCell.text = str
        self.roundImage()
    }

}
