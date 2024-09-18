//
//  NetWork.swift
//  KangBossWidgetExtension
//
//  Created by weixin on 2023/11/21.
//

import Foundation
import Moya
import KakaJSON

struct NetWork {
    
    static func makeProvider(target: CustomTargetType) -> MoyaProvider<CustomMultiTarget> {
        let stubBehavior = MoyaProvider<CustomMultiTarget>.neverStub
        // 组合插件
        var plugins: [PluginType] = []
#if DEBUG
        // 配置请求和响应JSON打印
        plugins.append(JSONPrintPlugin())
#endif
        let provider = MoyaProvider<CustomMultiTarget>(
            stubClosure: stubBehavior,
            plugins: plugins
        )
        return provider
    }
    
    static func request(_ target: CustomTargetType, successHandler: @escaping ((NetworkResponse) -> ()), errorHandler: @escaping ((NetworkError) -> ())) {
        _request(CustomMultiTarget(target)) { result in
            switch result {
            case .success(let response):
                successHandler(response)
            case .failure(let error):
                errorHandler(error)
            }
        }
    }
    
    private static func _request(_ target: CustomMultiTarget, successHandler: @escaping ((_ response: Result<NetworkResponse, NetworkError>) -> ())) {
        let provide = makeProvider(target: target)
        provide.request(target) { result in
            switch result {
            case .success(let response):
                let data = response.data
                guard var dict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
                    successHandler(.failure(NetworkError.dataFormatError(data)))
                    return
                }
                dict["url"] = response.request?.url ?? NewBaseUrl
                let netResponse = dict.kj.model(NetworkResponse.self)
                
                guard netResponse.code == .success || netResponse.code == .refreshToken else {
                    successHandler(.failure(NetworkError.accessFailed(netResponse)))
                    return
                }
                successHandler(.success(netResponse))
            case .failure(let error):
                successHandler(.failure(NetworkError.requestFailed(error)))
            }
        }
    }
}

extension NetWork {
    
    private struct DataModel<T>: Convertible {
        var data: T?
    }
    
    static func requestModel<T: Convertible>(_ target: CustomTargetType, modelType: T.Type, successHandler: @escaping ((T) -> ()), errorHandler: @escaping ((NetworkError) -> ())) {
        request(target) { response in
            // 开始解析
            guard let _ = response.data as? Dictionary<String, Any> else {
                let dict = ["data": ["result": response.data]]
                let dataModel = dict.kj.model(DataModel<T>.self)
                guard let model = dataModel.data else {
                    errorHandler(NetworkError.conversionFailed(response.data))
                    return
                }
                successHandler(model)
                return
            }
            let dataModel = ["data": response.data].kj.model(DataModel<T>.self)
            guard let model =  dataModel.data else {
                errorHandler(NetworkError.conversionFailed(response.data))
                return
            }
            successHandler(model)
        } errorHandler: { error in
            errorHandler(error)
        }
    }
}

// MARK: - 插件

struct JSONPrintPlugin: PluginType {
    
    func willSend(_ request: RequestType, target: TargetType) {
        print("🎈-------------------- Network request will send --------------------")
        print("target: ", target)
        if let request = request.request, let json = try? request.httpBody?.jsonObject() {
            print("requestURL: ", request.url as Any)
            print("requestMethod: ", request.httpMethod as Any)
            print("requestTimeoutInterval: ", request.timeoutInterval)
            print("requestHeaders: ", request.allHTTPHeaderFields as Any)
            print("requestJSON: ", JSONString(from: json, prettyPrinted: true))
        }
        print("-------------------- Network request will send --------------------")
    }
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        print("⛔️-------------------- Network request did receive --------------------")
        print("target: ", target)
        switch result {
        case .success(let response):
            print("success: ", JSONString(from: (try? response.data.jsonObject()) as Any, prettyPrinted: true))
        case .failure(let error):
            print("error: ", error)
        }
        print("-------------------- Network request did receive --------------------")
    }
}

// MARK: - Extension Methods
public extension Data {

    /// SwifterSwift: String by encoding Data using the given encoding (if applicable).
    ///
    /// - Parameter encoding: encoding.
    /// - Returns: String by encoding Data using the given encoding (if applicable).
    func string(encoding: String.Encoding) -> String? {
        return String(data: self, encoding: encoding)
    }

    /// SwifterSwift: Returns a Foundation object from given JSON data.
    ///
    /// - Parameter options: Options for reading the JSON data and creating the Foundation object.
    ///
    ///   For possible values, see `JSONSerialization.ReadingOptions`.
    /// - Returns: A Foundation object from the JSON data in the receiver, or `nil` if an error occurs.
    /// - Throws: An `NSError` if the receiver does not represent a valid JSON object.
    func jsonObject(options: JSONSerialization.ReadingOptions = []) throws -> Any {
        return try JSONSerialization.jsonObject(with: self, options: options)
    }
}
