//
//  TallyController.swift
//  Tally
//
//  Created by Matt Beaney on 29/10/2016.
//  Copyright © 2016 Matt Beaney. All rights reserved.
//

import Foundation

class TallyController: NSObject {
    
    static var shared: TallyController = TallyController()
    
    func retrieveTallies() -> [Tally] {
        if let tallyData: NSData = UserDefaults.standard.object(forKey: "tallies") as? NSData, let tallies: [Tally] = NSKeyedUnarchiver.unarchiveObject(with: tallyData as Data) as? [Tally] {
            return tallies
        }
        
        return []
    }
    
    func storeTallies(tallies: [Tally]) {
        var sortedTallies = tallies.sorted(by: {$0.type < $1.type})
        
        let data: Data = NSKeyedArchiver.archivedData(withRootObject: sortedTallies)
        UserDefaults.standard.set(data, forKey: "tallies")
    }
    
    func incrementTally(tally: Tally) {
        let tallies: [Tally] = self.retrieveTallies()
        for storedTally in tallies {
            if storedTally.type == tally.type {
                storedTally.count += 1
                self.storeTallies(tallies: tallies)
                return
            }
        }
    }
    
    func fetchTalliesFromData() {
        storeTallies(tallies: createNewTallies())
    }
    
    func createNewTallies() -> [Tally] {
        var tempTallies: [Tally] = []
        if let jsonResult: NSDictionary = unpackLocalJSON() {
            if let tallies: [NSDictionary] = jsonResult["tallies"] as? [NSDictionary] {
                for jsonTally in tallies {
                    let tally = Tally(json: jsonTally)
                    
                    if self.retrieveTallies().contains(where: { $0.type == tally.type }) {
                        let filteredArray = self.retrieveTallies().filter({ $0.type == tally.type })
                        if filteredArray.count > 0 {
                            tally.count = filteredArray[0].count
                        }
                    }
                    
                    tempTallies.append(tally)
                }
            }
            storeDict(dict: jsonResult)
        }
        
        return tempTallies
    }
    
    func unpackLocalJSON() -> NSDictionary? {
        if let path = Bundle.main.path(forResource: "data", ofType: "json") {
            do {
                if let jsonData = NSData(contentsOfFile: path)
                {
                    if let jsonResult: NSDictionary = try JSONSerialization.jsonObject(with: jsonData as Data, options: .allowFragments) as? NSDictionary {
                        return jsonResult
                    }
                }
            } catch {}
        }
        
        return nil

    }
    
    func storeDict(dict: NSDictionary) {
        UserDefaults.standard.set(dict, forKey: "storedDict")
    }
    
    func returnStoredDict() -> NSDictionary? {
        return UserDefaults.standard.object(forKey: "storedDict") as? NSDictionary
    }
}
