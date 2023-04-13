//
//  KuTabView.swift
//  KuComics
//
//  Created by weixin on 2023/4/10.
//

import SwiftUI

struct KuTabView_Previews: PreviewProvider {
    static var previews: some View {
        KuTabView(selectedTab: .constant(1))
    }
}

struct KuTabView: View {
    
    @Binding var selectedTab: Int
    @State var showDrawerView: Bool = false
    
    var body: some View {
        ZStack{
            TabView(selection: $selectedTab) {
                
                BookShelfView(showDrawerView: $showDrawerView)
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
                
                BookSourceView()
                    .tabItem {
                        Label("本地", systemImage: "opticaldiscdrive")
                            .foregroundColor(.yellow)
                    }
                    .tag(3)
            }
            .accentColor(Color.foreground)
        
            MaskView(bgColor: .black)
                .opacity(showDrawerView ? 1:0)
                .onTapGesture {
                    showDrawerView = false
                }
            drawerView.offset(x: showDrawerView ? 0 :-UIScreen.main.bounds.width)
        }
        .animation(.spring())
    }
    
    /// 抽屉
    var drawerView : some View {
        HStack {
            VStack {
                Image("drawer_img")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
               
                VStack(spacing: 16) {
                    DrawerCell(name: "图源",iconName: "drawer_source")
                    {BookSourceView()} action: {showDrawerView = false}
                    DrawerCell(name: "下载", iconName:"drawer_download")
                    {EmptyView()} action: {showDrawerView = false}
                    DrawerCell(name: "版本", iconName: "drawer_version")
                    {EmptyView()} action: {showDrawerView = false}
                    DrawerCell(name: "捐赠", iconName: "drawer_donation")
                    {EmptyView()} action: {showDrawerView = false}
                    DrawerCell(name: "反馈", iconName: "drawer_feedback")
                    {EmptyView()} action: {showDrawerView = false}
                    DrawerCell(name: "设置", iconName: "drawer_set")
                    {EmptyView()} action: {showDrawerView = false}
                    DrawerCell(name: "关于", iconName: "drawer_about")
                    {EmptyView()} action: {showDrawerView = false}
                }
                .padding(.vertical)
                
                Spacer()
            }
            .background(Color.white)
            .frame(maxWidth: UIScreen.main.bounds.width * 2/3.0)
            Spacer()
        }
        .ignoresSafeArea()
    }
}

struct DrawerCell<Destination: View>: View {
    @State private var isLinkActive: Bool = false
    var name: String
    var iconName: String
    let destination: () -> Destination
    var action: () -> Void = {}
    
    var body: some View {
        Group {
            Button {
                isLinkActive = true
                action()
            } label: {
                HStack {
                    Image(iconName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30,height: 30)
                    Text(name)
                        .foregroundColor(Color.grayText)
                        .padding(.leading, 8)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.vertical, 4)
            }
            NavigationLink(isActive: $isLinkActive, destination: destination, label: {})
        }
    }
}

