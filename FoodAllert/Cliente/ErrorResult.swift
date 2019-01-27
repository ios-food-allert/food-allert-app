//
//  ErrorResult.swift
//  Ekinplace
//
//  Created by Angel Ricardo Solsona Nevero on 30/10/18.
//  Copyright © 2018 Angel Ricardo Solsona Nevero. All rights reserved.
//

import Foundation

struct ErrorResult: Codable {
    let message: String
}

struct APIResult<T> where T:Codable{
    let statusCode: ClientStatusCode
    let message:String
    let resultObject:T?
}

struct GenericResponse<T>: Codable where T:Codable {
    let message: String
    let data: T
    let code: String
}
