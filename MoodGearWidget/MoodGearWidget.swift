//
//  MoodGearWidget.swift
//  MoodGearWidget
//
//  Created by Jackson Sanders on 11/21/25.
//

import WidgetKit
import SwiftUI


struct MoodWidgetEntry: TimelineEntry {
    let date: Date
    let moods: [Mood]
}

struct MoodWidgetProvider: TimelineProvider {
    func placeholder(in context: Context) -> MoodWidgetEntry {
        MoodWidgetEntry(date: Date(), moods: [])
    }

    func getSnapshot(in context: Context, completion: @escaping (MoodWidgetEntry) -> Void) {
        let moods = loadMoods()
        let entry = MoodWidgetEntry(date: Date(), moods: moods)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let moods = loadMoods()
        let entry = MoodWidgetEntry(date: Date(), moods: moods)
        
        let calendar = Calendar.current
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: Date())!
        let nextUpdate = calendar.startOfDay(for: tomorrow)
                
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
        completion(timeline)
    }
    
    private func loadMoods() -> [Mood] {
        let defaults = UserDefaults(suiteName: "group.com.JacksonSanders.MoodTrackerApp")
        if let data = defaults?.data(forKey: "moods"),
            let decoded = try? JSONDecoder().decode([Mood].self, from: data) {
            return decoded
        }
        return []
    }

//    func relevances() async -> WidgetRelevances<Void> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct MoodWidgetEntryView: View {
    var entry: MoodWidgetEntry
    @Environment(\.widgetFamily) var family
    
    var body: some View {
        switch family {
        case .accessoryCircular:
            MoodGearView(moods: entry.moods)
                .padding(4)
                .widgetAccentable()
        case .accessoryCorner:
            MoodGearView(moods: entry.moods)
                .padding(2)
                .widgetAccentable()
        case .accessoryRectangular:
            HStack {
                MoodGearView(moods: entry.moods)
                    .frame(width: 40, height: 40)
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Moods")
                        .font(.headline)
                    Text("\(entry.moods.count)/6")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal, 8)
            .widgetAccentable()
        default:
            MoodGearView(moods: entry.moods)
                .widgetAccentable()
        }
    }
}

@main
struct MoodWidget: Widget {
    let kind: String = "MoodWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: MoodWidgetProvider()) { entry in
            MoodWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Mood Gear")
        .description("Track your daily moods with a colorful gear.")
        .supportedFamilies([
            .accessoryCircular,
            .accessoryCorner,
            .accessoryRectangular
        ])
    }
}

//#Preview(as: .accessoryCircular) {
//    MoodWidget()
//} timeline: {
//    MoodWidgetEntry(date: .now, moods: [
//        Mood(type: .blue, timestamp: .now),
//        Mood(type: .green, timestamp: .now),
//        Mood(type: .red, timestamp: .now)
//    ])
//}

