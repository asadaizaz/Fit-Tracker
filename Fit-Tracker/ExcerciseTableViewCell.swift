//
//  ExcerciseTableViewCell.swift
//  Fit-Tracker
//
//  Created by Asad Aizaz on 2018-08-16.
//  Copyright © 2018 Asad Aizaz. All rights reserved.
//

import UIKit

class ExcerciseTableViewCell: UITableViewCell {

    //MARK: Properties
    
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
