//
//  CustomMultiTarget.swift
//  KangBossWidgetExtension
//
//  Created by weixin on 2023/11/21.
//

import Moya
import KakaJSON

enum CustomMultiTarget: CustomTargetType {
    
    var path: String {
        return target.path
    }
    
    var task: Moya.Task {
        return target.task
    }
    
    var baseURL: URL {
        return target.baseURL
    }
    
    var headers: [String : String]? {
        return target.headers
    }
    
    var method: Moya.Method {
        return target.method
    }
    
    var sampleData: Data {
        return target.sampleData
    }
    
    var validationType: ValidationType {
        return target.validationType
    }
    
    var timeoutInterval: TimeInterval? {
        return target.timeoutInterval
    }
    
    var mockDelaySeconds: TimeInterval? {
        return target.mockDelaySeconds
    }
    
    var isMockSwitchOn: Bool {
        return target.isMockSwitchOn
    }
    
    var retryCount: Int {
        return target.retryCount
    }
    
    func refreshUserToken(newToken: String) -> Bool {
        return target.refreshUserToken(newToken: newToken)
    }
    
    var cachePolicy: URLRequest.CachePolicy {
        return target.cachePolicy
    }
    
    /// The embedded `TargetType`.
    case target(CustomTargetType)
    
    /// Initializes a `CustomTarget`.
    init(_ target: CustomTargetType) {
        self = CustomMultiTarget.target(target)
    }
    
    /// The embedded `TargetType`.
    var target: CustomTargetType {
        switch self {
        case .target(let target): return target
        }
    }
    
}

internal extension TargetType {
    var baseURL: URL {
        return URL(string: NewBaseUrl)!
    }
    
    var headers: [String : String]? {
//        let timeStamp = Date().milliStamp
//        let nonce = "\(arc4random() + (UInt32(timeStamp) ?? 0))"

        return ["Content-Type": "application/json",
//                "appKey": TJLive_UserDefault.getAppKey(),
//                "nonce": nonce,
//                "timestamp": timeStamp,
//                "sign": String.getMD5(timestamp: timeStamp, nonce: nonce),
                "x-tojoy-app": "bh-mall",
                "x-tojoy-channel": "BH_MALL",
                "x-tojoy-channelId": ""]
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}


internal extension Moya.Task {
    
    /// 利用Convertible类型请求JSON数据，需要提前定义好类型
    /// - Parameter requestInfo: Convertible类型
    /// - Returns: Moya.Task实例
    static func requestJSONParameters(_ requestInfo: Convertible? = nil) -> Moya.Task {
        var parameters = JSONObject(from: RequestParameters(requestInfo: requestInfo))
        if parameters["requestInfo"] == nil {
            parameters["requestInfo"] = [String: Any]()
        }
        return .requestParameters(parameters: parameters, encoding: JSONEncoding())
    }
    
    /// 利用JSON类型([String: Any])请求JSON数据
    /// - Parameter requestInfo: JSON
    /// - Returns: Moya.Task实例
    static func requestJSONParameters(requestInfo: [String: Any]) -> Moya.Task {
        var parameters = JSONObject(from: RequestParameters())
        parameters["requestInfo"] = requestInfo
        return .requestParameters(parameters: parameters, encoding: JSONEncoding())
    }
    
    /// 利用JSON类型([String: Any])请求JSON数据
    /// - Parameter requestInfo: JSON
    /// - Parameter isUserInfo: 是否删除userinfo字段
    /// - Returns: Moya.Task实例
    static func requestJSONParameters(requestInfo: [String: Any], isUserInfo: Bool) -> Moya.Task {
        var parameters = JSONObject(from: RequestParameters())
        parameters["requestInfo"] = requestInfo
        if isUserInfo {
            parameters.removeValue(forKey: "userInfo")
        }
        return .requestParameters(parameters: parameters, encoding: JSONEncoding())
    }
}

protocol CustomTargetType: TargetType, MoyaCacheable {
    
    /// 请求超时时间，返回nil，默认使用15s
    var timeoutInterval: TimeInterval? { get }
    
    /// 模拟请求延时时间，返回nil，默认使用立即触发
    var mockDelaySeconds: TimeInterval? { get }
    
    /// 是否开启模拟请求，默认关闭
    var isMockSwitchOn: Bool { get }
    
    /// 重试次数，默认为0，不重试
    var retryCount: Int { get }
    
    /// 刷新用户token
    /// - Parameter newToken: 新token
    func refreshUserToken(newToken: String) -> Bool
}

extension CustomTargetType {
    
    var timeoutInterval: TimeInterval? {
        return nil
    }
    
    var mockDelaySeconds: TimeInterval? {
        return nil
    }
    
    var isMockSwitchOn: Bool {
        return false
    }
    
    var retryCount: Int {
        return 0
    }
    
    func refreshUserToken(newToken: String) -> Bool {
        /// 更新token
        return true
    }
}

internal extension CustomTargetType {
    var cachePolicy: URLRequest.CachePolicy {
        return .reloadIgnoringLocalCacheData
    }
}

