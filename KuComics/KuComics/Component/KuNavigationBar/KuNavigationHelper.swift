//
//  KuNavigationHelper.swift
//  KuComics
//
//  Created by weixin on 2023/4/10.
//

import UIKit

public typealias KuBlock = () -> Void

enum KuHelper {
    static let height: CGFloat = UIScreen.main.bounds.size.height

    static var safeAreaInsets: UIEdgeInsets {
        UIApplication.shared.windows.first?.safeAreaInsets ?? UIEdgeInsets.zero
    }
    
    static var navigationBarHeight: CGFloat {
        44.0 + safeAreaInsets.top
    }
    
    /// Portrait
    enum UnsafeArea {
        static var top: CGFloat {
            UIWindow.keyWindow?.safeAreaInsets.top ?? 0
        }
    }

    enum StatusBar {
        static var frame: CGRect {
            // 这个frame在预览状态获取不到高度
            UIWindow.keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? .zero
        }
        static let height: CGFloat = frame.size.height
    }

    enum NavigationBar {
        static let height: CGFloat = 44
        static let bottom: CGFloat = height + StatusBar.height
    }

    static var iphoneXSeries: Bool {
        if UIDevice.current.userInterfaceIdiom != UIUserInterfaceIdiom.phone {
            debugPrint("not iPhone - \(UIDevice.current.userInterfaceIdiom.rawValue)")
        }
        if #available(iOS 11.0, *) {
            if let bottom = UIWindow.keyWindow?.safeAreaInsets.bottom, bottom > 0 {
                return true
            }
        } else {
            debugPrint("iOS11 previews")
        }
        return false
    }
}

extension UIWindow {
    static var keyWindow: UIWindow? {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.windows.filter({ $0.isKeyWindow }).first
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
