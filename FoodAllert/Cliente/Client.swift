//
//  Client.swift
//  Worldb
//
//  Created by Luis Ezcurdia on 9/29/18.
//  Copyright © 2018 Luis Ezcurdia. All rights reserved.
//

import Foundation

typealias dataHandler = (Data?,ClientStatusCode) -> Void

struct Client {
    var baseURLComponents: URLComponents
    
    
    mutating func getParams(path: String, query:[String:String], headers:[String:String]?, successHandler: dataHandler?) {
        var arrayQuery:[URLQueryItem] = []
        
        for (key,value) in query{
            print(key,value)
            arrayQuery.append(URLQueryItem(name: key, value: value))
        }
        self.baseURLComponents.queryItems =  arrayQuery
        get(path: path,body: nil, headers:headers, successHandler: successHandler)
    }
    
    
    func get(path: String, successHandler: dataHandler?) {
        get(path: path, body: nil, headers: nil, successHandler: successHandler)
    }
    
    func get(path: String, body: Data?, headers:[String:String]?, successHandler: dataHandler?) {
        request("GET", path: path, body: body, headers:headers, successHandler: successHandler)
    }
    
    func post(path: String, body: Data?, headers:[String:String], successHandler: dataHandler?) {
        request("POST", path: path, body: body,headers: headers, successHandler: successHandler)
    }
    
    func put(path: String, body: Data?, successHandler: dataHandler?) {
        request("PUT", path: path, body: body, successHandler: successHandler)
    }
    
    func patch(path: String, body: Data?,headers:[String:String], successHandler: dataHandler?) {
        request("PATCH", path: path, body: body, headers: headers, successHandler: successHandler)
    }
    
    func delete(path: String, successHandler: dataHandler?) {
        delete(path: path, body: nil, headers:nil, successHandler: successHandler)
    }
    
    func delete(path: String, body: Data?, headers:[String:String]?, successHandler: dataHandler?) {
        request("DELETE", path: path, body: body, headers: headers ,successHandler: successHandler)
    }
    
    
    func request(_ method: String, path: String, body: Data?, successHandler: dataHandler?) {
        request(method, path: path, body: body, headers: nil, successHandler: successHandler)
    }
    
    func request(_ method: String, path: String, body: Data?, headers: [String:String]?, successHandler: dataHandler?) {
        
        var requestURLComponents = baseURLComponents
        requestURLComponents.path = path
        var request = URLRequest(url: requestURLComponents.url!)
        request.httpMethod = method
        request.httpBody = body
        print(requestURLComponents.url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let headers = headers{
            for (key,value) in headers{
                print(key,value)
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        debugPrint(request.allHTTPHeaderFields.debugDescription)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil { return }
            let httpResponse = response as! HTTPURLResponse
            print("Estatus de peticion",httpResponse.statusCode)
            print("Datos devueltos webservice",String(data: data ?? Data(), encoding: .utf8)!)
            if let handler = successHandler {
                let status = ClientStatusCode(rawValue: httpResponse.statusCode)
                handler(data,status)
            }
        }
        task.resume()
    }
}

public enum ClientStatusCode: Int {
    case unkown = 0
    case info        // 1xx
    case success     // 2xx
    case redirection // 3xx
    case clientError // 4xx
    case invalidToken // 401
    case duplicateData // 409
    case serverError // 5xx
    case error   = 10000
    case parserError
    
    public init(rawValue: Int) {
        switch rawValue {
        case 100, 101, 102:
            self = .info
        case 200, 201, 202, 203, 204, 205, 206, 207, 208, 226:
            self = .success
        case 300, 301, 302, 303, 304, 305, 306, 307, 308:
            self = .redirection
        case 400, 402, 403, 404, 405, 406, 407, 408, 410, 411, 412,
             413, 414, 415, 416, 417, 418, 421, 422, 423, 424, 426, 428, 429, 431, 451:
            self = .clientError
        case 401:
            self = .invalidToken
        case 409:
            self = .duplicateData
        case 500, 501, 502, 503, 504, 505, 506, 507, 510, 511:
            self = .serverError
        case 512..<10001:
            self = .error
        case 10001:
            self = .parserError
        default:
            self = .unkown
        }
    }
}
