//
//  MoodTrackerAppApp.swift
//  MoodTrackerApp Watch App
//
//  Created by Jackson Sanders on 11/21/25.
//

import SwiftUI

@main
struct MoodTrackerApp_Watch_AppApp: App {
    private let moodManager = MoodManager.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(moodManager)
        }
    }
}
