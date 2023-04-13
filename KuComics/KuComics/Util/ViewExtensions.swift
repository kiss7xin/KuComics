//
//  ViewExtensions.swift
//  KuComics
//
//  Created by weixin on 2023/4/10.
//

import SwiftUI

extension View {
    func gradientBackgroundColor() -> some View {
        self.background(LinearGradient(gradient: Gradient(colors: [Color("navbarbackgroundleft"), Color("navbarbackgroundright")]), startPoint: .leading, endPoint: .trailing))
    }
    
    func alert(isPresented: Binding<Bool>, content: () -> any View) -> some View {
        ZStack{
            self
            if isPresented.wrappedValue {
                ZStack{
                    Color.gray.opacity(0.5)
                    HStack(alignment: .center) {
                        VStack(alignment: .center) {
                            AnyView(content())
                        }.padding()
                    }
                    .background(Color.white)
                }
            }
        }.ignoresSafeArea()
    }
}

struct GradientBackgroundView: View {
    var body: some View
    {
        LinearGradient(gradient: Gradient(colors: [Color("navbarbackgroundleft"), Color("navbarbackgroundright")]), startPoint: .leading, endPoint: .trailing)
    }
}
