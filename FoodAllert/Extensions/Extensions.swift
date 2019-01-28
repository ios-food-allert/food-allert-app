//
//  Extensions.swift
//  FoodAllert
//
//  Created by Angel Ricardo Solsona Nevero on 1/27/19.
//  Copyright © 2019 José Gil Ramírez S. All rights reserved.
//

import Foundation


extension Array where Element:Equatable{
    func removeDuplicates() -> [Element] {
        var result = [Element]()
        
        for value in self{
            if result.contains(value) == false{
                result.append(value)
            }
        }
        return result
    }
}
