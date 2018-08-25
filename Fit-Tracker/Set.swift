//
//  Set.swift
//  Fit-Tracker
//
//  Created by Asad Aizaz on 2018-08-24.
//  Copyright © 2018 Asad Aizaz. All rights reserved.
//

import Foundation

class Set: NSObject, NSCoding{
    var repNumber: Int
    var lbsNumber: Int
    var saved: Bool
    init(repNumber:Int, lbsNumber:Int, saved:Bool = false)
    {
        self.repNumber = repNumber
        self.lbsNumber = lbsNumber
        self.saved = saved
    }
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.repNumber, forKey:"repNumber")
        aCoder.encode(self.lbsNumber, forKey: "lbsNumber")
        aCoder.encode(self.saved, forKey: "saved")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let r = aDecoder.decodeObject(forKey: "repNumber") as? Int ?? aDecoder.decodeInteger(forKey: "repNumber")
        let l = aDecoder.decodeObject(forKey: "lbsNumber") as? Int ?? aDecoder.decodeInteger(forKey: "lbsNumber")
        let s = aDecoder.decodeObject(forKey:"saved") as? Bool ?? aDecoder.decodeBool(forKey: "saved")
        self.init(repNumber: r, lbsNumber: l, saved:s)
        
    }
    
}
