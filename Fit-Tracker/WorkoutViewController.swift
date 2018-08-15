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
 
    @IBOutlet weak var routineLabel: UILabel!
    @IBOutlet weak var workoutLabel: UILabel!
    
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
  
    @IBAction func newRoutineButton(_ sender: UIButton) {
        
    }
    
    @IBAction func startWorkoutButton(_ sender: Any) {
    }
}
