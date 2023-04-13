//
//  KuComicsApp.swift
//  KuComics
//
//  Created by weixin on 2023/4/6.
//

import SwiftUI

@main
struct KuComicsApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AppSetting())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
