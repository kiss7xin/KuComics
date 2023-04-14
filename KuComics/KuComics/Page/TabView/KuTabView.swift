//
//  KuTabView.swift
//  KuComics
//
//  Created by weixin on 2023/4/10.
//

import SwiftUI

struct KuTabView_Previews: PreviewProvider {
    static var previews: some View {
        KuTabView(selectedTab: .constant(0))
    }
}

struct TabItemInfo: Equatable {
    let title: String
    let imageName: String
}

struct KuTabView: View {
    
    @State var isShowDrawer: Bool = false
    @Binding var selectedTab: Int
    
    private let tabItems = [
        TabItemInfo(title: "书架",imageName: "books.vertical"),
        TabItemInfo(title: "推荐",imageName: "crown"),
        TabItemInfo(title: "历史",imageName: "clock")
    ]
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                BookShelfPage(isShowDrawer: $isShowDrawer).tabItem {
                  createTabItem(tabItems[0])
                }.tag(0)
                RecommendPage(isShowDrawer: $isShowDrawer).tabItem {
                    createTabItem(tabItems[1])
                  }.tag(1)
                HistoryPage(isShowDrawer: $isShowDrawer).tabItem {
                    createTabItem(tabItems[2])
                  }.tag(2)
            }
            .background(Color.background)
            .accentColor(Color.foreground)
            
            DrawerPage(isShow: $isShowDrawer)
        }
    }
    
    @ViewBuilder
    func createTabItem(_ item: TabItemInfo) -> some View {
        Label(item.title, systemImage: item.imageName)
    }
    
}

