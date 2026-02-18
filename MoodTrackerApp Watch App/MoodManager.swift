//
//  MoodManager.swift
//  MoodsApp Watch App
//
//  Created by Jackson Sanders on 11/21/25.
//

import Foundation
import SwiftUI
import Observation
import WidgetKit


@Observable
class MoodManager {
    var moods: [Mood] = []
    
    private let defaults = UserDefaults(suiteName: "group.com.JacksonSanders.MoodTrackerApp")!
    
    private let moodsKey = "moods"
    private let lastResetKey = "lastResetDate"
    
    static let shared = MoodManager()
    
    init() {
        loadMoods()
        checkAndResetDaily()
    }
    
    func addMood(_ type: MoodType) {
        let newMood = Mood(type: type, timestamp: Date())
        moods.append(newMood)
        
        // Keep only last 6
        if moods.count > 6 {
            moods.removeFirst()
        }
        
        saveMoods()
        reloadWidget()
    }
    
    func clearAll() {
        moods.removeAll()
        saveMoods()
        reloadWidget()
    }
    
    func getMoods() -> [Mood] {
        return moods
    }
    
    private func saveMoods() {
        if let encoded = try? JSONEncoder().encode(moods) {
            defaults.set(encoded, forKey: moodsKey)
        }
    }
    
    private func loadMoods() {
        if let data = defaults.data(forKey: moodsKey),
           let decoded = try? JSONDecoder().decode([Mood].self, from: data) {
            moods = decoded
        }
    }
    
    private func checkAndResetDaily() {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        if let lastReset = defaults.object(forKey: lastResetKey) as? Date {
            let lastResetDay = calendar.startOfDay(for: lastReset)
            if today > lastResetDay {
                moods.removeAll()
                saveMoods()
                defaults.set(today, forKey: lastResetKey)
                reloadWidget()
            }
        } else {
            defaults.set(today, forKey: lastResetKey)
        }
    }
    
    private func reloadWidget() {
        WidgetCenter.shared.reloadAllTimelines()
    }
}

