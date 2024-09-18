//
//  ProductDetail.swift
//  KangBossWidgetExtension
//
//  Created by weixin on 2023/11/21.
//

import Foundation
import KakaJSON

struct ProductDetail: Convertible {
    /// 商品ID
    var spuId: String = ""
    /// 商品图片地址
    var imageUrl: String = ""
    /// 商品名称
    var name: String = ""
    /// 商品附标题
    var subhead: String = ""
    /// 商品销售价
    var sellPrice: Double = 0.0
    /// 商品市场价
    var marketPrice: Double = 0.0
}
