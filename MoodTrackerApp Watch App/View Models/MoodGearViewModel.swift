//
//  MoodGearViewModel.swift
//  MoodTrackerApp Watch App
//
//  Created by Jackson Sanders on 2/27/26.
//

import SwiftUI
import Observation

@Observable
final class MoodGearViewModel {
    private let controller = SegmentColoringController<Mood>()

    let toothCount = 6
    let fallbackColor = Color.gray.opacity(0.3)

    func colors(for moods: [Mood]) -> [Color] {
        controller.colors(
            segmentCount: toothCount,
            items: moods,
            fallback: fallbackColor,
            itemToColor: { $0.type.color },
            mapping: .reverseFillFromEnd
        )
    }

    func angle(for index: Int) -> Double {
        Double(index) * 60.0
    }
}
