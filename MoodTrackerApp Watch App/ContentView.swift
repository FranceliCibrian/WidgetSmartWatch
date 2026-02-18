//
//  ContentView.swift
//  MoodsApp Watch App
//
//  Created by Jackson Sanders on 11/10/25.
//
//This comment is for checking the repo!!!
import SwiftUI

struct ContentView: View {
    @State private var moodManager = MoodManager.shared
    
    var body: some View {
        VStack(spacing: 15) {
            // Gear visualization
            MoodGearView(moods: moodManager.moods)
                .frame(width: 100, height: 100)
            
            Text("\(moodManager.moods.count)/6")
                .font(.caption)
                .foregroundColor(.gray)
            
            // Mood buttons
            VStack(spacing: 10) {
                HStack(spacing: 10) {
                    MoodButton(color: .blue, label: "😌") {
                        moodManager.addMood(.blue)
                    }
                    MoodButton(color: .green, label: "😊") {
                        moodManager.addMood(.green)
                    }
                }
                HStack(spacing: 10) {
                    MoodButton(color: .yellow, label: "😐") {
                        moodManager.addMood(.yellow)
                    }
                    MoodButton(color: .red, label: "😟") {
                        moodManager.addMood(.red)
                    }
                }
            }
            
            if !moodManager.moods.isEmpty {
                Button("Clear") {
                    moodManager.clearAll()
                }
                .font(.caption)
                .foregroundColor(.red)
            }
        }
        .padding()
    }
}

struct MoodButton: View {
    let color: Color
    let label: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.title3)
                .frame(width: 70, height: 40)
                .background(color.opacity(0.3))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(color, lineWidth: 1.5)
                )
        }
        .buttonStyle(.plain)
    }
}

