//
//  DayView.swift
//  MarkedCalendar
//
//  Created by Nikol Lazarte on 21/03/24.
//

import SwiftUI

struct DayView: View {
    let date: Date?
    let closeRange: ClosedRange<Date>
    let isSelected: Bool
    let isToday: Bool
    let markedDate: MarkedDate?
    let calendar: Calendar

    @Environment(\.isEnabled) private var isEnabled: Bool

    enum Sizes {
        static let frameCircle: CGFloat = 5
        static let maxOrders: Int = 3
    }

    private var isInRange: Bool {
        guard let date = date else { return false }
        return closeRange.contains(date)
    }

    private var textColor: Color {
        if !isEnabled {
            return Color.gray
        } else if !isInRange {
            return Color.gray
        } else if isSelected {
            return isToday ? .white : .black
        } else if isToday {
            return .blue
        } else {
            return Color.gray
        }
    }

    private var fillColor: Color {
        if !isEnabled {
            return .gray
        } else if isSelected {
            return isToday ? .white : .blue
        } else {
            return .blue
        }
    }

    private var backgroundColor: Color {
        if isSelected {
            if isToday {
                return .blue
            } else {
                return .blue.opacity(5)
            }
        } else {
            return .clear
        }
    }

    var body: some View {
        VStack(spacing: Constants.Spacing.xxxxsmall) {
            if let date = date {
                Text(date.day)
                    .foregroundColor(textColor)
                    .font(isToday ? .caption.bold() : .caption)
            }

            if markedDate != nil {
                Circle()
                    .fill(fillColor)
                    .frame(width: Sizes.frameCircle, height: Sizes.frameCircle)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: Constants.Spacing.medium, alignment: .top)
        .padding(.vertical, Constants.Spacing.xxxsmall)
        .background(backgroundColor)
    }
}
