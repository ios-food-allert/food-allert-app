//
//  FoodPrediccion.swift
//  FoodAllert
//
//  Created by Angel Ricardo Solsona Nevero on 1/26/19.
//  Copyright © 2019 José Gil Ramírez S. All rights reserved.
//

struct FoodPrediccion: Codable {
    let entities: [Entity]
    let intents: [Intent]
}

struct Entity: Codable, Equatable {
    let entity: String
    let location: [Int]
    let value: String
    let confidence: Double
    let imageURL: String
    
    static func == (lhs:Entity, rhs:Entity) -> Bool{
        return lhs.entity == rhs.entity && lhs.imageURL == rhs.imageURL
    }
}

struct Intent: Codable {
    let intent: String
    let confidence: Double
}
