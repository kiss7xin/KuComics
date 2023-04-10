//
//  AppSetting.swift
//  KuComics
//
//  Created by weixin on 2023/4/10.
//

import SwiftUI

class AppSetting: ObservableObject {
    @Published var darkModeSettings: Int = UserDefaults.standard.integer(forKey: "darkMode") {
        didSet {
            UserDefaults.standard.set(self.darkModeSettings, forKey: "darkMode")
            let scenes = UIApplication.shared.connectedScenes
            let windowscene = scenes.first as? UIWindowScene
            let window = windowscene?.windows.first
            switch self.darkModeSettings {
            case 0:
                window?.overrideUserInterfaceStyle = .unspecified
            case 1:
                window?.overrideUserInterfaceStyle = .light
            case 2:
                window?.overrideUserInterfaceStyle = .dark
            default:
                window?.overrideUserInterfaceStyle = .unspecified
            }
        }
    }
}
