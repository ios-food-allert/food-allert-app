//
//  CustomValue.swift
//  FoodAllert
//
//  Created by Angel Ricardo Solsona Nevero on 20/01/19.
//  Copyright © 2019 José Gil Ramírez S. All rights reserved.
//

import Foundation
enum CustomValue: Codable{
    
    case int(Int)
    case string(String)
    case double(Double)
    
    func encode(to encoder: Encoder) throws {
        
    }
    
    init(from decoder: Decoder) throws {
        if let int = try? decoder.singleValueContainer().decode(Int.self) {
            self = .int(int)
            return
        }
        
        if let string = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(string)
            return
        }
        
        if let double = try? decoder.singleValueContainer().decode(Double.self){
            self = .double(double)
            return
        }
        
        throw QuantumError.missingValue
    }
    
    enum QuantumError:Error {
        case missingValue
    }
}
