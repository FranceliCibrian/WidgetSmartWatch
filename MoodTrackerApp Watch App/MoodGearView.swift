//
//  MoodGearView.swift
//  MoodsApp Watch App
//
//  Created by Jackson Sanders on 11/21/25.
//

import SwiftUI

struct MoodGearView: View {
    let moods: [Mood]
    
    var body: some View {
        ZStack {
            // Center circle
            Circle()
                .fill(Color.gray.opacity(0.2))
                .frame(width: 40, height: 40)
            
            // 6 gear teeth
            ForEach(0..<6, id: \.self) { index in
                GearTooth(
                    color: colorForTooth(at: index),
                    angle: Double(index) * 60.0
                )
            }
            
            // Center decoration
            Circle()
                .stroke(Color.gray.opacity(0.5), lineWidth: 1.5)
                .frame(width: 40, height: 40)
        }
    }
    
    private func colorForTooth(at index: Int) -> Color {
        let moodIndex = moods.count - 1 - index
        
        if moodIndex >= 0 && moodIndex < moods.count {
            return moods[moodIndex].type.color
        } else {
            return Color.gray.opacity(0.3)
        }
    }
}
//This comment is to test if the repo is fixed
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

