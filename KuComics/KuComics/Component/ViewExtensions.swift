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
}

struct GradientBackgroundView: View {
    var body: some View
    {
        LinearGradient(gradient: Gradient(colors: [Color("navbarbackgroundleft"), Color("navbarbackgroundright")]), startPoint: .leading, endPoint: .trailing)
    }
}
