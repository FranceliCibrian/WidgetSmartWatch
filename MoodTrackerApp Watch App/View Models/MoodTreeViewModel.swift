//
//  MoodTreeViewModel.swift
//  MoodTrackerApp Watch App
//
//  Created by Jackson Sanders on 3/9/26.
//
import SwiftUI
import Observation

struct MoodSegment {
    let color: Color
    let startFraction: CGFloat
    let endFraction: CGFloat
}

@Observable
final class MoodTreeViewModel {

    func segments(for moods: [Mood?]) -> [MoodSegment] {
        let totalSlots = moods.count
        guard totalSlots > 0 else { return [] }
        let slotSize = 1.0 / CGFloat(totalSlots)
        var result: [MoodSegment] = []
        for (index, mood) in moods.enumerated() {
            if let mood = mood {
                result.append(MoodSegment(
                    color: mood.type.color,
                    startFraction: CGFloat(index) * slotSize,
                    endFraction: CGFloat(index + 1) * slotSize
                ))
            }
        }
        return result
    }
}
