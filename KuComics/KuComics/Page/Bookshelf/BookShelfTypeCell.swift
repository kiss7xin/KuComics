//
//  BookShelfTypeCell.swift
//  KuComics
//
//  Created by weixin on 2023/4/10.
//

import SwiftUI

struct BookShelfTypeCell: View {
    var title: String
    var menus: [String]
    @Binding var selected: Int
    var body: some View {
        HStack() {
            Text(title)
            Spacer()
            Picker("", selection: $selected) {
                ForEach(0..<menus.count) { idx in
                    Text(menus[idx]).tag(idx)
                }
            }
            .pickerStyle(.segmented)
            .frame(maxWidth: 200)
            .padding(.vertical)
        }
    }
}

struct BookShelfTypeCell_Previews: PreviewProvider {
    static var previews: some View {
        BookShelfTypeCell(title: "视图", menus: ["列表","网格"], selected: .constant(1))
    }
}
