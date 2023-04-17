//
//  BookSourceModel.swift
//  KuComics
//
//  Created by weixin on 2023/4/7.
//

import Foundation
import KakaJSON

enum BookSourceType: Int, ConvertibleEnum {
    case cartoon
    case wallpaper
    case video
}

/// 图源信息
struct BookSource: Convertible, Identifiable, Equatable {
    var id = UUID()
    /// 图源基础信息
    /// 图源名称
    var bookSourceName = ""
    /// 图源分组
    var bookSourceGroup = ""
    /// 图源类型
    var bookSourceType: BookSourceType = .cartoon
    /// 图源备注
    var sourceRemark = ""
    /// 图源域名
    var bookSourceUrl = ""
    /// 登录网页:登录URL | 填写网站登录网址,仅在需要登录的图源有用
    var loginUrl = ""
    /// 登录结果
    var loginUrlResult = ""
    
    /// 书籍发现规则
    /// 发现分类菜单规则
    var ruleFindUrl = ""
    
    /// 书籍搜索规则
    /// 搜索网址 [域名可省略]/search.php@kw=searchKey|char=utf-8
    var ruleSearchUrl = ""
    /// 结果列表 搜索页列表规则(ruleSearchList) | 选择书籍节点 (规则结果为List<Element>)
    var ruleSearchList = ""
    /// 搜索翻页:搜索列表下一页规则 | [域名可省略]/search.php@kw=searchKey|char=utf-8
    var ruleSearchUrlNext = ""
    /// 书籍名称:搜索页书名规则 | 选择节点书名 (规则结果为String)
    var ruleSearchName = ""
    /// 书籍作者:搜索页作者规则 | 选择节点作者 (规则结果为String)
    var ruleSearchAuthor = ""
    /// 书籍分类:搜索页分类规则 | 选择节点分类信息 (规则结果为List<String>)
    var ruleSearchKind = ""
    /// 最新章节:搜索页最新章节规则 | 选择节点最新章节 (规则结果为String)
    var ruleSearchLastChapter = ""
    /// 封面链接:搜索页封面规则 | 选择节点书籍封面 (规则结果为Url)
    var ruleSearchCoverUrl = ""
    /// 详情链接:搜索页详情规则 | 选择书籍详情页网址 (规则结果为Url)
    var ruleSearchNoteUrl = ""
    
    /// 书籍详情规则
    ///书籍名称:书名规则 | 选择详情页书名 (规则结果为String)
    var ruleBookName = ""
    /// 书籍作者:作者规则 | 选择详情页作者 (规则结果为String)
    var ruleBookAuthor = ""
    /// 书籍分类:分类规则 | 选择详情页分类信息 (规则结果为List<String>)
    var ruleBookKind = ""
    /// 最新章节:最新章节规则 | 选择详情页最新章节 (规则结果为String)
    var ruleBookLastChapter = ""
    /// 简介内容:简介规则 | 选择详情页书籍简介 (规则结果为String)
    var ruleIntroduce = ""
    /// 封面链接:封面规则 | 选择详情页书籍封面 (规则结果为Url)
    var ruleCoverUrl = ""
    /// 目录链接:目录URL规则 | 选择目录页网址 (规则结果为Url, 与详情页相同时可省略)
    var ruleChapterUrl = ""
    
    /// 目录列表规则
    /// 目录翻页:目录下一页规则 | 选择目录下一页链接 (规则结果为List<Url>)
    var ruleChapterUrlNext = ""
    /// 目录列表:目录列表规则 | 选择目录列表的章节节点 (规则结果为List<Element>)
    var ruleChapterList = ""
    /// 分级标识:章节分级标识规则 | 选择章节分级标识 (规则结果为String)
    var ruleChapterParentId = ""
    /// 分级名称:章节分级名称规则 | 选择章节分级名称 (规则结果为String)
    var ruleChapterParentName = ""
    /// 章节名称:章节名称规则 | 选择章节名称 (规则结果为String)
    var ruleChapterName = ""
    /// 章节链接:章节URL规则 | 选择章节链接 (规则结果为Url)
    var ruleContentUrl = ""
    /// 章节标识:章节ID规则 | 选择章节ID (规则结果为String)
    var ruleChapterId = ""
    
    /// 正文阅读规则
    /// 章节正文:正文规则 | 选择正文内容 (规则结果为String)
    var ruleBookContent = ""
    /// 正文后期:正文后期规则 | 选择正文内容解析 (规则结果为byte[])
    var ruleBookContentDecoder = ""
    /// 正文翻页:正文翻页URL规则 | 选择下一分页(不是下一章)链接 (规则结果为Url)
    var ruleContentUrlNext = ""
    
    /// 其它规则
    /// 浏览标识:浏览器UA | 浏览器标识:User-Agent (可选)
    var httpUserAgent = "iOS"
    /// 排序编号:整数: 0~N (可选,默认0) | 数字越小越靠前
    var serialNumber = 0
    /// 搜索权重:整数: 0~N (可选,默认0) | 数字越大越靠前
    var weight = 0
    /// 是否启用:默认启用=true,手动启用=false (可选,默认true)
    var enable = true
    
    
    // 判断相等
    static func == (lhs: Self, rhs: Self) -> Bool {
        if lhs.bookSourceUrl == rhs.bookSourceUrl, lhs.ruleSearchUrl == rhs.ruleSearchUrl {
            return true
        }
        return false
    }
}
