//
//  WorkoutViewController.swift
//  Fit-Tracker
//
//  Created by Asad Aizaz on 2018-08-15.
//  Copyright © 2018 Asad Aizaz. All rights reserved.
//

import UIKit

class WorkoutViewController: UIStackView {
    //MARK: Properties
 
    @IBOutlet weak var welcomeText: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        didLoad()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        didLoad()
    }
    
    
    func didLoad() {
        //Initialization code
        
    }
    //MARK: Actions
  
    @IBAction func startWorkoutButton(_ sender: UIButton) {
    }
    
    @IBAction func routineButton(_ sender: UIButton) {
    }
}
