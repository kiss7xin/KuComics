//
//  LazyView.swift
//  KuComics
//
//  Created by weixin on 2023/4/14.
//

import SwiftUI

public struct LazyView<Content: View>: View {
    
    private let build: () -> Content
    public init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    
    public var body: Content {
        build()
    }
}
