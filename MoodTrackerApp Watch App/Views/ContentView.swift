//
//  ContentView.swift
//  MoodsApp Watch App
//
//  Created by Jackson Sanders on 11/10/25.
//
//This comment is for checking the repo!!!
import SwiftUI

struct ContentView: View {
    @Environment(MoodManager.self) private var moodManager
    
    var body: some View {
        VStack(spacing: 6) {
            MoodTreeView(moods: moodManager.moods)
                .frame(width: 55, height: 55)
            
            // Mood buttons
            VStack(spacing: 6) {
                HStack(spacing: 8) {
                    MoodButton(color: .blue, label: "😌") {
                        moodManager.addMood(.blue)
                    }
                    MoodButton(color: .green, label: "😊") {
                        moodManager.addMood(.green)
                    }
                }
                HStack(spacing: 8) {
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
                .font(.caption2)
                .foregroundColor(.red)
            }
        }
        .padding(.horizontal)
    }
}

struct MoodButton: View {
    let color: Color
    let label: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.body)
                .frame(width: 60, height: 32)
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

