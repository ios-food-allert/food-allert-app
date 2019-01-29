//
//  Article.swift
//  FoodAllert
//
//  Created by José Gil Ramírez S on 1/28/19.
//  Copyright © 2019 José Gil Ramírez S. All rights reserved.
//

import Foundation

struct Article: Codable {
    let title: String
    let abstract: String
    let imageURL: String
    let articleURL: String
    
    init(title: String,
         abstract: String,
         imageURL: String,
         articleURL: String) {
        self.title = title
        self.abstract = abstract
        self.imageURL = imageURL
        self.articleURL = articleURL
    }
}
