//
//  Core.swift
//  Ekinplace
//
//  Created by Angel Ricardo Solsona Nevero on 11/10/18.
//  Copyright © 2018 Angel Ricardo Solsona Nevero. All rights reserved.
//

import Foundation

enum APIHost{
    case food
    case ingredients
}

struct API {
    let schema:String
    let host:String
    let api:String
    
    init(apiHost:APIHost) {
        if apiHost == .food{
            self.schema = "https"
            self.host = "world.openfoodfacts.org"
            self.api = ""
        }else{
            self.schema = "https"
            self.host = "api-fa-backend.1d35.starter-us-east-1.openshiftapps.com"
            self.api = "/services/rest"
        }
    }
    
    var urlEndpoint:String {
        return "\(self.schema)://\(self.host)"
    }
    
    enum EndPoint {
        case searchCode
        case prediccionFood
        
        var url:String {
            var relativePath: String = "/"
            switch self {
            case .searchCode:
                relativePath.append("code")
            case .prediccionFood:
                relativePath.append("sendAssistantInput")
            }
            return relativePath
        }
        
    }
    
    func getEndpoint(endpoint:EndPoint) -> String {
        print("\(self.api)/\(endpoint.url)")
        return "\(self.api)\(endpoint.url)"
    }
    
    
    
    
}
