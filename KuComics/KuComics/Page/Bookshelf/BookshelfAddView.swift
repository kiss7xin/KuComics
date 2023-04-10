//
//  BookshelfAddView.swift
//  KuComics
//
//  Created by weixin on 2023/4/10.
//

import SwiftUI

struct BookshelfAddView: View {
    
    @State var nameField: String = ""
    var body: some View {
        KuNavigationBar {
            VStack {
                GroupBox{
                    TextField("书架名称", text: $nameField)
                    Divider().padding(.bottom)
                    BookShelfTypeCell(title: "视图", menus: ["列表","网格"])
                    BookShelfTypeCell(title: "排序", menus: ["时间","拖拽"])
                }
                .padding()
                Spacer()
                Button{
                    
                } label: {
                    Text("保存")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.black)
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                        .padding(.bottom, KuHelper.safeAreaInsets.bottom)
                }
            }
            .background(Color.background)
        }
        .title("新增书架")
        .background(LinearGradient(
            gradient: Gradient(colors: [
                Color("navbarbackgroundleft"), Color("navbarbackgroundright")
            ]),
            startPoint: .leading, endPoint: .trailing))
        .isBackButtonBlack(false)
        .foreground(.white)
    }
}

struct BookshelfAddView_Previews: PreviewProvider {
    static var previews: some View {
        BookshelfAddView()
    }
}
