//
//  KangBossAPI.swift
//  KangBossWidgetExtension
//
//  Created by weixin on 2023/11/21.
//

import Foundation
import Moya
import KakaJSON

let NewBaseUrl: String = "https://uat-steamengine-api.kang-boss.com"

enum KangBossAPI {
    case productDetail(_ spuId: String, _ skuId: String = "")
}

extension KangBossAPI: CustomTargetType {
    
    var path: String {
        switch self {
        case .productDetail:
            "/goods/app/v2/goodsInfo"
        }
    }
    
    var task: Task {
        var parmeters: [String : Any] = [:]
        switch self {
        case .productDetail(let spuId, let skuId):
            parmeters = ["spuId": spuId,
                         "skuId": skuId]
            return .requestJSONParameters(requestInfo: parmeters)
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json",
                "x-tojoy-channelId": "",
                "platformId": "10",
                "X-Auth-Belong": "miniprogram",
                "x-tojoy-accountId": "100000",
                "X-Auth-Token": "", // token
                "x-tojoy-appId": "10012",
                "x-tojoy-source": "bh-mall",
                "x-tojoy-app": "bh-mall",
                "x-auth-type": "mobile"]
    }
}
