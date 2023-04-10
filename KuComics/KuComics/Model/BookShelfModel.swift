//
//  BookShelfModel.swift
//  KuComics
//
//  Created by weixin on 2023/4/10.
//

import Foundation

enum BookShelfViewStyle: Int {
    case list
    case grid
}

enum BookShelfSort: Int {
    case time
    case drag
}

struct BookShelfItem: Identifiable {
    var id = UUID()
    var name:String = ""
    var viewStyle: BookShelfViewStyle = .list
    var sort: BookShelfSort = .time
}

