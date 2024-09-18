//
//  RequestParameters.swift
//  KangBossWidgetExtension
//
//  Created by weixin on 2023/11/21.
//

import Foundation
import KakaJSON

struct RequestParameters: Convertible {
    
    var clientInfo = ClientInfo()
    var deviceInfo = DeviceInfo()
    var userInfo = UserInfo()
    var requestInfo: Convertible?
    
    struct ClientInfo: Convertible {
        var clientSource: String = "APPLET" //"APP_IOS"
        var clientVersion: String = ""
        var clientVersionCode: String = ""
        var platform: String = "YUNSHANG"
        var token: String = ""
    }
    
    struct DeviceInfo: Convertible {
        var systemType: String = ""
        var systemVersion: String = ""
    }
    struct UserInfo: Convertible {
        var userId: String = ""
        var userName: String = ""
    }
    init() {}
    
    init(requestInfo: Convertible?) {
        self.requestInfo = requestInfo
    }
}


/// 接口响应信息
struct NetworkResponse: Convertible {
    /// 请求地址
    var url: String = NewBaseUrl
    /// 响应code
    var code: NetworkCode = .unknown
    /// 响应信息
    var msg: String = ""
    ///相应错误信息
    var message: String = ""
    /// 响应数据
    var data: Any?
    /// 系统时间戳
    var timestamp: String = ""
    /// 分页数量
    var page: RequestPage?
}

struct RequestPage: Convertible {
    var index: Int = 0
    var size: Int = 0
    var pages: Int = 0
    var total: Int = 0
}

import Moya
protocol MoyaCacheable {
    typealias MoyaCacheablePolicy = URLRequest.CachePolicy
    var cachePolicy: MoyaCacheablePolicy { get }
}

final class MoyaCacheablePlugin: PluginType {
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        if let type = target as? CustomTargetType {
            var mutableRequest = request
            mutableRequest.cachePolicy = type.cachePolicy
            return mutableRequest
        }
        return request
    }
}
