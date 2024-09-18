//
//  WidgetExtension.swift
//  KangBossActivityExtension
//
//  Created by weixin on 2023/11/23.
//

import SwiftUI

extension View {
    func widgetBackground(_ backgroundView: some View) -> some View {
        // 如果是 iOS 17，则使用 containerBackground
        if #available(iOSApplicationExtension 17.0, *) {
            return containerBackground(for: .widget) {
                backgroundView
            }
        } else {
            return background(backgroundView)
        }
    }
}

extension WidgetConfiguration {
    func disableContentMarginsIfNeeded() -> some WidgetConfiguration {
        if #available(iOSApplicationExtension 17.0, *) {
            return self.contentMarginsDisabled()
        } else {
            return self
        }
    }
}
