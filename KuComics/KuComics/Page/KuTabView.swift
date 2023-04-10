//
//  KuTabView.swift
//  KuComics
//
//  Created by weixin on 2023/4/10.
//

import SwiftUI

struct KuTabView: View {
    @Binding var selectedTab: Int
    var body: some View {
        TabView(selection: $selectedTab) {
            VStack(spacing:20) {
                BookShelfView()
            }
            .background(Color.background)
            .tabItem {
                Label("书架", systemImage: "books.vertical")
            }
            .tag(1)
            
            VStack(spacing: 20) {
                Text("Tab 2")
            }
            .tabItem {
                Label("推荐", systemImage: "crown")
                    .foregroundColor(.yellow)
            }
            .tag(2)
            
            VStack(spacing: 20) {
                Text("Tab 2")
            }
            .tabItem {
                Label("历史", systemImage: "clock")
                    .foregroundColor(.yellow)
            }
            .tag(3)
            
            VStack(spacing: 20) {
                Text("Tab 2")
            }
            .tabItem {
                Label("本地", systemImage: "opticaldiscdrive")
                    .foregroundColor(.yellow)
            }
            .tag(3)
        }
        .font(.title)
        .accentColor(Color.foreground)
    }
}

struct KuTabView_Previews: PreviewProvider {
    static var previews: some View {
        KuTabView(selectedTab: .constant(1))
    }
}
