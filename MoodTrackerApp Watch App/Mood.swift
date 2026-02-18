//
//  Mood.swift
//  MoodsApp Watch App
//
//  Created by Jackson Sanders on 11/10/25.
import Foundation
import SwiftUI

enum MoodType: String, Codable {
    case blue, green, yellow, red
    
    var color: Color {
        switch self {
        case .blue: return .blue
        case .green: return .green
        case .yellow: return .yellow
        case .red: return .red
        }
    }
}

struct Mood: Codable, Identifiable {
    let id: UUID
    let type: MoodType
    let timestamp: Date
    
    init(type: MoodType, timestamp: Date = Date()) {
        self.id = UUID()
        self.type = type
        self.timestamp = timestamp
    }
}

