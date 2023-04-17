//
//  BookSourceEditPage.swift
//  KuComics
//
//  Created by weixin on 2023/4/17.
//

import SwiftUI

struct BookSourceEditPage: View {
    var bookSource: BookSource?
    
    init(bookSource: BookSource? = nil) {
        self.bookSource = bookSource
    }
    
    var body: some View {
        Text("BookSourceEditPage")
    }
}

struct BookSourceEditPage_Previews: PreviewProvider {
    static var previews: some View {
        BookSourceEditPage()
    }
}
