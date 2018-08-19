//
//  Routine.swift
//  Fit-Tracker
//
//  Created by Asad Aizaz on 2018-08-17.
//  Copyright © 2018 Asad Aizaz. All rights reserved.
//

import Foundation

class Routine: NSObject, NSCoding {
    
    
    var name: String
    var exercises = [Exercise]()
    
    init(name:String, exercises: [Exercise]) {
        self.name = name
        self.exercises = exercises
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey:"name")
        aCoder.encode(exercises, forKey: "exercises")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey:"name") as! String
        let exercises = aDecoder.decodeObject(forKey:"exercises") as! [Exercise]
        self.init(name:name, exercises:exercises)
        
    }
}
