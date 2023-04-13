//
//  MaskView.swift
//  KuComics
//
//  Created by weixin on 2023/4/11.
//

import SwiftUI

struct MaskView: View {
    var bgColor: Color
    
    var body: some View {
        VStack{
            Spacer()
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(bgColor)
        .edgesIgnoringSafeArea(.all)
        .opacity(0.5)
    }
}
