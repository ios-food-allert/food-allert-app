//
//  FoodService.swift
//  FoodAllert
//
//  Created by Angel Ricardo Solsona Nevero on 18/01/19.
//  Copyright © 2019 José Gil Ramírez S. All rights reserved.
//

import Foundation

class FoodService{
    
    static let sharedInstance = FoodService()
    let core:API
    var client:Client
    
    init() {
        self.core = API(apiHost: .food)
        self.client = Client(baseURLComponents:URLComponents(string: core.urlEndpoint)!)
    }
    
    func search(code code:String, completion:@escaping(APIResult<FoodResponse>)-> Void){
        client.get(path: core.getEndpoint(endpoint: .searchCode)+"/\(code).json") { (data, status) in
            guard let data = data else { return }
            do {
                var apiResult:APIResult<FoodResponse>
                if status == .success{
                    let result = try JSONDecoder().decode(FoodResponse.self, from: data)
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
    }
}
