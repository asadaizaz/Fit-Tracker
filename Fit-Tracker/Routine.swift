//
//  Routine.swift
//  Fit-Tracker
//
//  Created by Asad Aizaz on 2018-08-17.
//  Copyright © 2018 Asad Aizaz. All rights reserved.
//

import Foundation

class Routine {
    var name: String
    var exercises = [Exercise]()
    
    init(name:String, exercises: [Exercise]) {
        self.name = name
        self.exercises = exercises
    }
}
