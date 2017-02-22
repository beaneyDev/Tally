//
//  Tally.swift
//  Tally
//
//  Created by Matt Beaney on 29/10/2016.
//  Copyright © 2016 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit

class Tally: NSObject, NSCoding {
    var type: String = ""
    var count: Int = 0
    var backgroundColor: UIColor?
    
    init(json: NSDictionary) {
        super.init()
        self.type = json["type"] as? String ?? ""
        self.count = 0
        self.backgroundColor = self.getRandomColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        type = aDecoder.decodeObject(forKey: "type") as! String
        count = aDecoder.decodeInteger(forKey: "count") as! Int
        backgroundColor = aDecoder.decodeObject(forKey: "backgroundColor") as? UIColor
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.type, forKey: "type")
        aCoder.encode(self.count, forKey: "count")
        aCoder.encode(self.backgroundColor, forKey: "backgroundColor")
    }
    
    
    func getRandomColor() -> UIColor{
        
        let randomRed:CGFloat = CGFloat(drand48())
        
        let randomGreen:CGFloat = CGFloat(drand48())
        
        let randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
    }
}
