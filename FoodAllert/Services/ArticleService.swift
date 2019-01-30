//
//  ArticleService.swift
//  Articles & New Features
//
//  Created by José Gil Ramírez S on 1/29/19.
//  Copyright © 2019 José Gil Ramírez S. All rights reserved.
//

import Foundation

class ArticleService {
    static let sharedInstance = ArticleService()
    let core: API
    var client: Client
    
    init() {
        self.core = API(apiHost: .ingredients)
        self.client = Client(baseURLComponents: URLComponents(string: core.urlEndpoint)!)
    }
    
    let jsonDecoder = JSONDecoder()
    
    func getArticleList(_ completion: @escaping ([Article]) -> Void) {
        client.get(path: core.getEndpoint(endpoint: .articles)) { (data, status) in
            guard let jsonData = data else { return }

            if status == .success {
                let result = try? self.jsonDecoder.decode([Article].self, from: jsonData)
                DispatchQueue.main.async {
                    completion(result ?? [Article]())
                }
            }
        }
    }
}
