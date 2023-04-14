//
//  DrawerPage.swift
//  KuComics
//
//  Created by weixin on 2023/4/14.
//

import SwiftUI

struct DrawerPage: View {
    
    @Binding var isShow: Bool
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
            .opacity(0.5)
            .onTapGesture {
                withAnimation {
                    isShow = false
                }
            }
            
            drawerView.offset(x: isShow ? 0 :-UIScreen.main.bounds.width)
        }
        .opacity(isShow ? 1:0)
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
                    {BookSourcePage()} action: {dismiss()}
                    DrawerCell(name: "下载", iconName:"drawer_download")
                    {EmptyView()} action: {dismiss()}
                    DrawerCell(name: "版本", iconName: "drawer_version")
                    {EmptyView()} action: {dismiss()}
                    DrawerCell(name: "捐赠", iconName: "drawer_donation")
                    {EmptyView()} action: {dismiss()}
                    DrawerCell(name: "反馈", iconName: "drawer_feedback")
                    {EmptyView()} action: {dismiss()}
                    DrawerCell(name: "设置", iconName: "drawer_set")
                    {EmptyView()} action: {dismiss()}
                    DrawerCell(name: "关于", iconName: "drawer_about")
                    {EmptyView()} action: {dismiss()}
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
    
    private func dismiss() {
        isShow = false
    }
}

struct DrawerPage_Previews: PreviewProvider {
    static var previews: some View {
        DrawerPage(isShow: .constant(true))
    }
}
