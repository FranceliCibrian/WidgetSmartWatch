//
//  MoodGearView.swift
//  MoodsApp Watch App
//
//  Created by Jackson Sanders on 11/21/25.
//

import SwiftUI

struct MoodGearView: View {
    let moods: [Mood]

    @State private var viewModel = MoodGearViewModel()

    var body: some View {
        let colors = viewModel.colors(for: moods)

        ZStack {
            Circle()
                .fill(Color.gray.opacity(0.2))
                .frame(width: 40, height: 40)

            ForEach(0..<viewModel.toothCount, id: \.self) { index in
                GearTooth(
                    color: colors[index],
                    angle: viewModel.angle(for: index)
                )
            }

            Circle()
                .stroke(Color.gray.opacity(0.5), lineWidth: 1.5)
                .frame(width: 40, height: 40)
        }
    }
}

struct GearTooth: View {
    let color: Color
    let angle: Double

    var body: some View {
        ToothShape()
            .fill(color)
            .frame(width: 25, height: 35)
            .offset(y: -37.5)
            .rotationEffect(.degrees(angle))
    }
}

struct ToothShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height

        path.move(to: CGPoint(x: width * 0.3, y: height))
        path.addLine(to: CGPoint(x: width * 0.1, y: height * 0.3))
        path.addQuadCurve(
            to: CGPoint(x: width * 0.9, y: height * 0.3),
            control: CGPoint(x: width * 0.5, y: 0)
        )
        path.addLine(to: CGPoint(x: width * 0.7, y: height))
        path.closeSubpath()

        return path
    }
}
