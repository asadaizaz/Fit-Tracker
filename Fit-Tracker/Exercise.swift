//
//  Exercise.swift
//  Fit-Tracker
//
//  Created by Asad Aizaz on 2018-08-17.
//  Copyright © 2018 Asad Aizaz. All rights reserved.
//

import Foundation

class Exercise {
    var name: String
    var isSelected: Bool
    init(name:String, isSelected:Bool = false)
    {
        self.name = name
        self.isSelected = isSelected
    }
}
