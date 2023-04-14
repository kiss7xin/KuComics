//
//  HistoryPage.swift
//  KuComics
//
//  Created by weixin on 2023/4/14.
//

import SwiftUI

struct HistoryPage: View {
    
    @Binding var isShowDrawer: Bool
    
    var body: some View {
        KuNavigationBar {
            VStack(spacing: 0) {
                Text("历史列表")
            }
        }
        .background(GradientBackgroundView())
        .hiddenLine(true)
        .backButtonHidden(true)
        .title("历史")
        .KuNavigationBarItems {
            Button {
                withAnimation {
                    self.isShowDrawer = true
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

struct HistoryPage_Previews: PreviewProvider {
    static var previews: some View {
        HistoryPage(isShowDrawer: .constant(false))
    }
}
