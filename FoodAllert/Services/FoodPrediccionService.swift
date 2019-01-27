//
//  FoodPrediccionService.swift
//  FoodAllert
//
//  Created by Angel Ricardo Solsona Nevero on 1/27/19.
//  Copyright © 2019 José Gil Ramírez S. All rights reserved.
//

import Foundation

class FoodPrediccionService{
    
    static let sharedInstance = FoodPrediccionService()
    let core:API
    var client:Client
    
    init() {
        self.core = API(apiHost: .ingredients)
        self.client = Client(baseURLComponents:URLComponents(string: core.urlEndpoint)!)
    }
    
    func search(ingredient:String, completion:@escaping(APIResult<FoodPrediccion>)-> Void){
        
        let params = [
            "userInput": ingredient,
            "alternate_intents": true
            ] as [String : Any]
        do{
            let data = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            
            let username = "food-allert"
            let password = "allert.food"
            let loginString = String(format: "%@:%@", username, password)
            let loginData = loginString.data(using: String.Encoding.utf8)!
            let base64LoginString = loginData.base64EncodedString()
            
            let header = ["Authorization":"Basic \(base64LoginString)"]
            client.post(path: core.getEndpoint(endpoint: .prediccionFood), body: data, headers: header) { (data, status) in
                guard let data = data else {return}
                do {
                    var apiResult:APIResult<FoodPrediccion>
                    if status == .success{
                        let result = try JSONDecoder().decode(FoodPrediccion.self, from: data)
                        apiResult = APIResult(statusCode: status,message: "Food found", resultObject: result)
                    }else{
                        apiResult = APIResult(statusCode: status,message: "Error al obtener service provider", resultObject: nil)
                    }
                    
                    DispatchQueue.main.async {
                        completion(apiResult)
                    }
                }catch let error{
                    debugPrint(error)
                }
            }
            
        }catch let error{
            print("Error \(error))")
        }

    }
}
