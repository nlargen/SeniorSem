//
//  FamilyDataCell.swift
//  RememberMe
//
//  Created by Nicholas Largen on 12/7/15.
//  Copyright © 2015 Nicholas Largen. All rights reserved.
//

import UIKit

class FamilyDataCell: UITableViewCell
{

    
    
    @IBOutlet weak var FMNameLabel: UILabel!
    
    @IBOutlet weak var FMAgeLabel: UILabel!
    @IBOutlet weak var FMRelationLabel: UILabel!
   
    @IBOutlet weak var FamImage: UIImageView!
    
    
    
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
