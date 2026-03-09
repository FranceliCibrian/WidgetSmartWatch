//
//  MoodTreeViewModel.swift
//  MoodTrackerApp Watch App
//
//  Created by Jackson Sanders on 3/9/26.
//
import SwiftUI
import Observation

@Observable
final class MoodTreeViewModel {
    private let controller = SegmentColoringController<Mood>()

    let fallbackColor = Color.gray.opacity(0.25)

    let leaves: [LeafLayout] = [
        LeafLayout(assetName: "top-left-leaf",
                   width: 16, height: 16,
                   offsetX: -10, offsetY: -16),

        LeafLayout(assetName: "center-top-leaf",
                   width: 16, height: 16,
                   offsetX: 0, offsetY: -24),

        LeafLayout(assetName: "top-right-leaf",
                   width: 16, height: 16,
                   offsetX: 10, offsetY: -16),

        LeafLayout(assetName: "bottom-left-leaf",
                   width: 16, height: 16,
                   offsetX: -8, offsetY: -2),

        LeafLayout(assetName: "bottom-right-leaf",
                   width: 16, height: 16,
                   offsetX: 8, offsetY: -2)
    ]

    func colors(for moods: [Mood]) -> [Color] {
        controller.colors(
            segmentCount: leaves.count,
            items: moods,
            fallback: fallbackColor,
            itemToColor: { $0.type.color },
            mapping: .reverseFillFromEnd
        )
    }
}

struct LeafLayout {
    let assetName: String
    let width: CGFloat
    let height: CGFloat
    let offsetX: CGFloat
    let offsetY: CGFloat
}
