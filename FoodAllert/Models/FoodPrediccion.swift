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
    let entityEs:String
    let location: [Int]
    let value: String
    let confidence: Double
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case entity, location, value, confidence, imageURL
        case entityEs = "entity_es"
    }
    
    static func == (lhs:Entity, rhs:Entity) -> Bool{
        return lhs.entity == rhs.entity && lhs.imageURL == rhs.imageURL
    }
    
}

struct Intent: Codable {
    let intent: String
    let confidence: Double
}
