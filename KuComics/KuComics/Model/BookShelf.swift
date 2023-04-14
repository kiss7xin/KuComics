//
//  BookShelfModel.swift
//  KuComics
//
//  Created by weixin on 2023/4/10.
//

import Foundation

enum BookShelfPageStyle: Int {
    case list
    case grid
}

enum BookShelfSort: Int {
    case time
    case drag
}

/// 书架分类
struct BookShelfItem: Identifiable {
    var id = UUID()
    var name: String = ""
    var viewStyle: BookShelfPageStyle = .list
    var sort: BookShelfSort = .time
    var couldDelete: Bool = true
    var bookList: [String] = []
}

