//
//  BookModel.swift
//  KuComics
//
//  Created by weixin on 2023/4/11.
//

import Foundation

// 书籍搜索结果
struct BookSearch: Identifiable {
    
    var id = UUID()
    /// 封面图
    var searchUrl = ""
    /// 漫画名称
    var comicName = ""
    /// 漫画图源名称
    var bookSourceName = ""
    /// 作者
    var bookAuthor = ""
    ///
}
