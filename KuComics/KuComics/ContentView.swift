//
//  ContentView.swift
//  KuComics
//
//  Created by weixin on 2023/4/6.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTab = 1
    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                VStack(spacing:20) {
                    Text("TabView").font(.largeTitle)
                    Button("Go to tab 2") {
                        selectedTab = 2 // step1:设置选中tab
                    }
                    Spacer()
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
            .navigationBarHidden(true)
            .accentColor(Color.foreground)
        }
        .background(Color.background)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
