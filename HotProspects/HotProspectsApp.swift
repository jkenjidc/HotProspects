//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Kenji Dela Cruz on 8/15/24.
//

import UserNotifications
import SwiftUI
import SwiftData
@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
