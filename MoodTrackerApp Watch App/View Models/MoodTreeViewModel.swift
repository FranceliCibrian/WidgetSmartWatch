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

    let fallbackColor = Color.gray.opacity(0.25)

    // Clockwise from top
    let leaves: [LeafLayout] = [
        LeafLayout(assetName: "center-top-leaf",  width: 16, height: 16, offsetX: 0,   offsetY: -24),
        LeafLayout(assetName: "top-right-leaf",   width: 16, height: 16, offsetX: 10,  offsetY: -16),
        LeafLayout(assetName: "bottom-right-leaf",width: 16, height: 16, offsetX: 8,   offsetY: -2),
        LeafLayout(assetName: "bottom-left-leaf", width: 16, height: 16, offsetX: -8,  offsetY: -2),
        LeafLayout(assetName: "top-left-leaf",    width: 16, height: 16, offsetX: -10, offsetY: -16)
    ]

    func colors(for moods: [Mood?]) -> [Color] {

        leaves.indices.map { index in
            if let mood = moods[index] {
                return mood.type.color
            } else {
                return fallbackColor
            }
        }
    }
}

struct LeafLayout {
    let assetName: String
    let width: CGFloat
    let height: CGFloat
    let offsetX: CGFloat
    let offsetY: CGFloat
}
