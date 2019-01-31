//
//  Preferences.swift
//  FoodAllert
//
//  Created by Angel Ricardo Solsona Nevero on 1/30/19.
//  Copyright © 2019 José Gil Ramírez S. All rights reserved.
//

import Foundation

class Preferences{
    static let sharedInstance = Preferences()
    private let userDefaults = UserDefaults.standard
    func savePreference(allergens:[String]){
        var string = ""
        for value in allergens{
            if value == allergens.last{
                string = string.appending(value)
            }else{
                string = string.appending("\(value),")
            }
        }
        self.userDefaults.set(string, forKey: "allergens")
        
    }
    
    func getPreferences() -> [String]{
        let string = self.userDefaults.object(forKey: "allergens") as! String
        let allegens = string.components(separatedBy:",")
        return allegens
    }
    
    func existConcidence(allergens:[String]) -> Bool{
        
        let allergensUser = self.getPreferences()
        
        let (success,_) =  allergensUser.containsElemets(array: allergens)
       
        return success
    }
    
    func existPreferences() -> Bool{
        guard (self.userDefaults.object(forKey: "allergens") as? String) != nil else {return false}
        return true
    }
    
}
