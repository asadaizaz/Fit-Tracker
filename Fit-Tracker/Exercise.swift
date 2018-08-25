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
    var sets = [Set]()
    init(name:String, isSelected:Bool = false, sets:[Set] = [])
    {
        self.name = name
        self.isSelected = isSelected
        self.sets = sets
    }
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey:"exerciseName")
        aCoder.encode(sets, forKey: "sets")

        aCoder.encode(isSelected, forKey: "isSelected")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey:"exerciseName") as! String
        

        let isSelected = aDecoder.decodeObject(forKey:"isSelected") as? Bool ?? aDecoder.decodeBool(forKey: "isSelected")
        
        if (aDecoder.decodeObject(forKey: "sets") != nil ) {
           let  sets = aDecoder.decodeObject(forKey: "sets") as! [Set]
            self.init(name:name, isSelected:isSelected, sets: sets)

        }else{
        
        self.init(name:name, isSelected:isSelected, sets: [])
        }
        
    }
    
}
