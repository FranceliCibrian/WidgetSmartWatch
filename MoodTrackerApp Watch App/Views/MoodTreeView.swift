//
//  MoodTreeView.swift
//  MoodTrackerApp Watch App
//
//  Created by Jackson Sanders on 2/13/26.
//

import SwiftUI
import WidgetKit

struct MoodTreeView: View {
    let moods: [Mood?]
    var isWidget: Bool = false

    private let viewModel = MoodTreeViewModel()
    private let ringLineWidth: CGFloat = 5

    var body: some View {
        let segments = viewModel.segments(for: moods)

        ZStack {
            // Progress arc background
            ArcSegment(startAngle: .degrees(180), endAngle: .degrees(360), lineWidth: ringLineWidth)
                .fill(Color.gray.opacity(0.3))

            // Colored segments
            ForEach(segments.indices, id: \.self) { index in
                ArcSegment(
                    startAngle: .degrees(segments[index].startFraction * 180 + 180),
                    endAngle: .degrees(segments[index].endFraction * 180 + 180),
                    lineWidth: ringLineWidth
                )
                .fill(segments[index].color)
            }
            .widgetAccentable()

            // Tree composed from asset images
            ZStack {
                Image("trunk")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 34)
                    .offset(y: 4)

                Image("center-top-leaf")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 12, height: 14)
                    .offset(x: 1, y: -14)

                Image("top-right-leaf")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 14, height: 13)
                    .offset(x: 10, y: -9)

                Image("top-left-leaf")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 14, height: 13)
                    .offset(x: -10, y: -9)

                Image("bottom-right-leaf")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 13, height: 12)
                    .offset(x: 11, y: 1)

                Image("bottom-left-leaf")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 13, height: 12)
                    .offset(x: -11, y: 1)
            }
            .foregroundStyle(.white)
            .scaleEffect(0.7)
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

struct ArcSegment: Shape {
    let startAngle: Angle
    let endAngle: Angle
    let lineWidth: CGFloat

    func path(in rect: CGRect) -> Path {
        let radius = min(rect.width, rect.height) / 2
        let innerRadius = radius - lineWidth
        let center = CGPoint(x: rect.midX, y: rect.midY)

        var path = Path()
        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        path.addArc(center: center, radius: innerRadius, startAngle: endAngle, endAngle: startAngle, clockwise: true)
        path.closeSubpath()
        return path
    }
}

