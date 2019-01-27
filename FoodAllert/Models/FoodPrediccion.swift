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

struct Entity: Codable {
    let entity: String
    let location: [Int]
    let value: String
    let confidence: Int
    let imageURL: String
}

struct Intent: Codable {
    let intent: String
    let confidence: Double
}
