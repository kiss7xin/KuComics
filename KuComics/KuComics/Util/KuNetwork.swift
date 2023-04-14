//
//  KuNetwork.swift
//  KuComics
//
//  Created by weixin on 2023/4/14.
//

import Foundation
import Alamofire
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
        AlamofireLayer.requestData(method, URLString: url, parameters: parameters) { result in
            callback(result)
        }
    }
        
    public static func postRequest(_ URLString: String, parameters: [String : Any]?, callback: @escaping (Any) -> ()) {
        AlamofireLayer.requestData(MethodType.post, URLString: URLString, parameters: parameters) { result in
            callback(result)
        }
    }
}

class AlamofireLayer {
    class func requestData(_ type: MethodType, URLString : String, parameters : [String : Any]? = nil, callback :  @escaping (_ result : Any) -> ()) {
        
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        AF.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            switch response.result {
            case .success(let json):
                callback(json)
                break
            case .failure(let error):
                print("error:\(error)")
                break
            }
        }
    }
}
