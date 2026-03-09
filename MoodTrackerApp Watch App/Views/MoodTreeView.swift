//
//  MoodTreeView.swift
//  MoodTrackerApp Watch App
//
//  Created by Jackson Sanders on 2/13/26.
//

import SwiftUI

struct MoodTreeView: View {
    let moods: [Mood]

    @State private var viewModel = MoodTreeViewModel()

    var body: some View {
        let colors = viewModel.colors(for: moods)

        ZStack {
            Image("trunk")
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 46)

            ForEach(Array(viewModel.leaves.enumerated()), id: \.offset) { index, leaf in
                maskedLeaf(leaf.assetName, color: colors[index])
                    .frame(width: leaf.width, height: leaf.height)
                    .offset(x: leaf.offsetX, y: leaf.offsetY)
            }
        }
        .frame(width: 60, height: 60)
    }

    private func maskedLeaf(_ assetName: String, color: Color) -> some View {
        color
            .mask(
                Image(assetName)
                    .resizable()
                    .scaledToFit()
            )
    }
}


