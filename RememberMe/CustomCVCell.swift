//
//  CustomCVCell.swift
//  RememberMe
//
//  Created by Nicholas Largen on 12/7/15.
//  Copyright © 2015 Nicholas Largen. All rights reserved.
//

import UIKit

class CustomCVCell: UITableViewCell
{
    @IBOutlet weak var reminderTypeLabel: UILabel!
    
    @IBOutlet weak var FMAgeLabel: UILabel!
    @IBOutlet weak var FMImage: UIImageView!
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    
}
