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
    let overview: String
    let imageURL: String
    let articleURL: String
    
    init(title: String,
         overview: String,
         imageURL: String,
         articleURL: String) {
        self.title = title
        self.overview = overview
        self.imageURL = imageURL
        self.articleURL = articleURL
    }
    
    static func create(dictionary: NSDictionary) -> Article? {
        guard let title = dictionary["title"] as? String else { return nil }
        guard let overview = dictionary["overview"] as? String else { return nil }
        guard let imageURL = dictionary["imageURL"] as? String else { return nil }
        guard let articleURL = dictionary["articleURL"] as? String else { return nil }
        
        return Article(title: title, overview: overview, imageURL: imageURL, articleURL: articleURL)
    }
}

