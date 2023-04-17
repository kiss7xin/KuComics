//
//  KuNetwork.swift
//  KuComics
//
//  Created by weixin on 2023/4/14.
//

import Foundation
import KakaJSON

enum FetchStatus {
    case idle
    case fetching
    case failed
}

enum MethodType {
    case get
    case post
}

enum ServiceError: Error {
    case jsonDecodeFailure
}

class KuNet {
    
    public static func request(_ url: String, method : MethodType = .get, parameters: [String : Any]?, callback: @escaping (Any) -> ()) {
        BaseNet.request(method, URLString: url, parameters: parameters) { result in
            callback(result)
        }
    }
        
    public static func postRequest(_ URLString: String, parameters: [String : Any]?, callback: @escaping (Any) -> ()) {
        BaseNet.request(MethodType.post, URLString: URLString, parameters: parameters) { result in
            callback(result)
        }
    }
    
    
}

class BaseNet {
    
    class func request(_ type: MethodType, URLString : String, parameters : [String : Any]? = nil, callback :  @escaping (_ result : Any) -> ()) {
        
        let url = URL(string: URLString)!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        if type == .get {
            request.httpMethod = "GET"
        } else {
            request.httpMethod = "POST"
        }
        request.addValue("text/plain",forHTTPHeaderField: "Accept")
        session.dataTask(with: request as URLRequest) { data, response, error in
            if let data = data,
            let httpResponse = response as? HTTPURLResponse, (200..<300) ~= httpResponse.statusCode,
            let strData = String(bytes: data, encoding: .utf8) {
                callback(strData)
            }
        }.resume()
    }
    
    
}
