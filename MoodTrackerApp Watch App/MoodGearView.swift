//
//  MoodGearView.swift
//  MoodsApp Watch App
//
//  Created by Jackson Sanders on 11/21/25.
//

import SwiftUI

struct MoodGearView: View {
    let moods: [Mood]

    @StateObject private var viewModel = MoodGearViewModel()

    var body: some View {
        ZStack {
            Circle()
                .fill(Color.gray.opacity(0.2))
                .frame(width: 40, height: 40)

            ForEach(0..<viewModel.toothCount, id: \.self) { index in
                GearTooth(
                    color: viewModel.color(for: index),
                    angle: viewModel.angle(for: index)
                )
            }

            Circle()
                .stroke(Color.gray.opacity(0.5), lineWidth: 1.5)
                .frame(width: 40, height: 40)
        }
        .onAppear { viewModel.update(with: moods) }
        .onChange(of: moods.count) { _ in
            viewModel.update(with: moods)
        }
    }
}

