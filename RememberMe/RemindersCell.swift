//
//  RemindersCell.swift
//  RememberMe
//
//  Created by Nick Largen on 5/3/16.
//  Copyright © 2016 Nicholas Largen. All rights reserved.
//

import UIKit

class RemindersCell: UITableViewCell {
    
    @IBOutlet weak var ReminderDateLabel: UILabel!
    @IBOutlet weak var ReminderTypeLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
