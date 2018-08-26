//
//  SavedRoutine.swift
//  Fit-Tracker
//
//  Created by Asad Aizaz on 2018-08-25.
//  Copyright © 2018 Asad Aizaz. All rights reserved.
//

import Foundation
class SavedRoutine: NSObject, NSCoding {
    
    var routine: Routine
    var date: NSDate
    init(routine: Routine, date: NSDate) {
        self.routine = routine
        self.date = date
        
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(routine, forKey:"saveRoutine")
        aCoder.encode(date, forKey: "date")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let r = aDecoder.decodeObject(forKey: "saveRoutine") as! Routine
        let d = aDecoder.decodeObject(forKey: "date") as! NSDate
        self.init(routine: r, date: d)
    }
}
