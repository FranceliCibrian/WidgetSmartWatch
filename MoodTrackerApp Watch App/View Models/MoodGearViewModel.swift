//
//  MoodGearViewModel.swift
//  MoodTrackerApp Watch App
//
//  Created by Jackson Sanders on 2/27/26.
//

import Foundation
import SwiftUI

@MainActor
final class MoodGearViewModel: ObservableObject {
    @Published private(set) var toothColors: [Color] = []

    private let controller = SegmentColoringController<Mood>()

    let toothCount: Int = 6
    let fallbackColor: Color = Color.gray.opacity(0.3)

    func update(with moods: [Mood]) {
        toothColors = controller.colors(
            segmentCount: toothCount,
            items: moods,
            fallback: fallbackColor,
            itemToColor: { $0.type.color },
            mapping: .reverseFillFromEnd
        )
    }

    func angle(for index: Int) -> Double {
        Double(index) * (360.0 / Double(toothCount)) // 0, 60, 120...
    }

    func color(for index: Int) -> Color {
        guard toothColors.indices.contains(index) else { return fallbackColor }
        return toothColors[index]
    }
}
