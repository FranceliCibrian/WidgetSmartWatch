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
    var moods: [Mood?] = Array(repeating: nil, count: 5)
    var nextIndex: Int = 0
    
    private let defaults = UserDefaults(suiteName: "group.com.JacksonSanders.MoodTrackerApp")!
    
    private let moodsKey = "moods"
    private let nextIndexKey = "nextIndex"
    private let lastResetKey = "lastResetDate"
    
    static let shared = MoodManager()
    
    init() {
        loadMoods()
        checkAndResetDaily()
    }
    
    func addMood(_ type: MoodType) {
        checkAndResetDaily() 
        let newMood = Mood(type: type, timestamp: Date())
        moods[nextIndex] = newMood
        nextIndex = (nextIndex + 1) % moods.count

        saveMoods()
        reloadWidget()
    }
    
    func clearAll() {
        moods = Array(repeating: nil, count: 5)
        nextIndex = 0
        saveMoods()
        reloadWidget()
    }
    
    func getMoods() -> [Mood] {
        moods.compactMap { $0 }
    }
    
    private func saveMoods() {
        let compactMoods = moods.map { $0 }
        if let encoded = try? JSONEncoder().encode(compactMoods) {
            defaults.set(encoded, forKey: moodsKey)
            defaults.set(nextIndex, forKey: nextIndexKey)
        }
    }
    
    private func loadMoods() {
        if let data = defaults.data(forKey: moodsKey),
           let decoded = try? JSONDecoder().decode([Mood?].self, from: data) {
            moods = decoded
        }
        
        if defaults.object(forKey: nextIndexKey) != nil {
            nextIndex = defaults.integer(forKey: nextIndexKey)
        }
    }
    
    private func checkAndResetDaily() {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        if let lastReset = defaults.object(forKey: lastResetKey) as? Date {
            let lastResetDay = calendar.startOfDay(for: lastReset)
            if today > lastResetDay {
                moods = Array(repeating: nil, count: 5)
                nextIndex = 0
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

