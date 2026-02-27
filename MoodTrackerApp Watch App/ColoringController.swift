//
//  ColoringController.swift
//  MoodTrackerApp Watch App
//
//  Created by Jackson Sanders on 2/27/26.
//

import Foundation
import SwiftUI

struct SegmentColoringController<Item> {
    typealias ColorProvider = (Item) -> Color

    func colors(
        segmentCount: Int,
        items: [Item],
        fallback: Color,
        itemToColor: ColorProvider,
        mapping: SegmentMapping = .reverseFillFromEnd
    ) -> [Color] {
        guard segmentCount > 0 else { return [] }

        return (0..<segmentCount).map { segmentIndex in
            let itemIndex = mapping.itemIndex(for: segmentIndex, itemCount: items.count)

            if let itemIndex, items.indices.contains(itemIndex) {
                return itemToColor(items[itemIndex])
            } else {
                return fallback
            }
        }
    }
}

enum SegmentMapping {

    case reverseFillFromEnd

    case forwardFillFromStart

    func itemIndex(for segmentIndex: Int, itemCount: Int) -> Int? {
        guard itemCount > 0 else { return nil }

        switch self {
        case .reverseFillFromEnd:
            let idx = itemCount - 1 - segmentIndex
            return idx >= 0 ? idx : nil

        case .forwardFillFromStart:
            let idx = segmentIndex
            return idx < itemCount ? idx : nil
        }
    }
}
