//
//  ContentView.swift
//  KuComics
//
//  Created by weixin on 2023/4/6.
//

import SwiftUI
struct ContentView: View {
    
    @EnvironmentObject var appSetting: AppSetting
    @State private var selectedTab = 1
    
    var body: some View {
        NavigationView {
            KuTabView(selectedTab: $selectedTab)
        }
        .onAppear{
            appSetting.darkModeSettings = appSetting.darkModeSettings
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
