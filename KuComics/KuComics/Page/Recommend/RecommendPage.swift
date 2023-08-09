//
//  RecommendPage.swift
//  KuComics
//
//  Created by weixin on 2023/4/14.
//

import SwiftUI

struct RecommendPage: View {
    @Binding var isShowDrawer: Bool
    
    var body: some View {
        Text("Hello, World!")
    }
}


struct RecommendPage_Previews: PreviewProvider {
    static var previews: some View {
        RecommendPage(isShowDrawer: .constant(false))
    }
}
