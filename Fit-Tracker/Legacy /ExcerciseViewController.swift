//
//  ExcerciseViewController.swift
//  Fit-Tracker
//
//  Created by Asad Aizaz on 2018-08-17.
//  Copyright © 2018 Asad Aizaz. All rights reserved.
//

import UIKit

class ExcerciseViewController: UIView {

    @IBOutlet weak var tableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        didLoad()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        didLoad()
    }
    
    
    func didLoad()
    {
    
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
