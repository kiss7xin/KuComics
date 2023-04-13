//
//  BookShelfView.swift
//  KuComics
//
//  Created by weixin on 2023/4/10.
//

import SwiftUI

struct BookShelfView_Previews: PreviewProvider {
    static var previews: some View {
        BookShelfView(showDrawerView: .constant(false))
    }
}

struct BookShelfView: View {
    @Binding var showDrawerView:Bool
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \BookShelf.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<BookShelf>
    
    var body: some View {
        KuNavigationBar {
            VStack(spacing: 0) {
                // 分组栏
                HStack {
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing: 20) {
                            ForEach(items) {item in
                                Button{
                                    
                                } label: {
                                    Text(item.name ?? "")
                                }
                            }
                        }
                    }
                    
                    NavigationLink {
                        BookshelfAddView()
                    } label: {
                        Image.shelfEdit
                    }
                }
                .frame(maxWidth: .infinity)
                .font(.system(size: 16))
                .padding(.horizontal)
                .frame(height: 36)
                .background(GradientBackgroundView())
                .foregroundColor(Color.text)
                
                BookShelfTabView()
            }
        }
        .background(GradientBackgroundView())
        .hiddenLine(true)
        .backButtonHidden(true)
        .navigationBarTitleView {
            Button {
                
            } label: {
                HStack(spacing: 8) {
                    Image.search
                    Text("搜索漫画名或作者")
                    Spacer()
                }
                .font(.system(size: 16))
                .padding(.horizontal)
                .frame(height: 30)
                .frame(maxWidth: .infinity)
                .background(Color.white.opacity(0.3))
                .cornerRadius(15)
                .padding(.horizontal, 8)
                .foregroundColor(.white)
            }
        }
        .KuNavigationBarItems {
            Button {
                withAnimation {
                    showDrawerView = true
                }
            } label: {
                Image.menu
                    .foregroundColor(.white)
                    .font(.system(size: 16))
            }
        } trailing: {
            Button {
                
            } label: {
                Image.plus
                    .foregroundColor(.white)
                    .font(.system(size: 16))
            }
        }
    }
}
