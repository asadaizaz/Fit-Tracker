//
//  Exercise.swift
//  Fit-Tracker
//
//  Created by Asad Aizaz on 2018-08-17.
//  Copyright © 2018 Asad Aizaz. All rights reserved.
//

import Foundation

class Exercise: NSObject, NSCoding {
    
    
    var name: String
    var isSelected: Bool = false
    init(name:String, isSelected:Bool = false)
    {
        self.name = name
        self.isSelected = isSelected
    }
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey:"exerciseName")
        aCoder.encode(isSelected, forKey: "isSelected")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey:"exerciseName") as! String
        

        let isSelected = aDecoder.decodeObject(forKey:"isSelected") as? Bool ?? aDecoder.decodeBool(forKey: "isSelected")
        self.init(name:name, isSelected:isSelected)
        
        }
    
}
