//
//  WineExploreApp.swift
//  WineExplore
//
//  Created by Taehyung Lee on 2022/09/13.
//

import SwiftUI
import FirebaseCore

@main
struct WineExploreApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
