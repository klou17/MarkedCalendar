//
//  MarkedCalendarViewModel.swift
//  MarkedCalendar
//
//  Created by Nikol Lazarte on 21/03/24.
//

import Foundation

final class MarkedCalendarViewModel: ObservableObject {
    let specialDates: [MarkedDate]
    let numberOfRows: Int
    let calendar: Calendar
    let closeRange: ClosedRange<Date>

    var canMoveToPreviousMonth: Bool {
        guard let previousMonth = calendar.date(byAdding: .month, value: -1, to: displayedMonth) else { return false }
        return previousMonth >= closeRange.lowerBound
    }

    var canMoveToNextMonth: Bool {
        guard let nextMonth = calendar.date(byAdding: .month, value: 1, to: displayedMonth) else { return false }
        return nextMonth <= closeRange.upperBound
    }

    var daysOfWeek: [String] {
        calendar.shortWeekdaySymbols
    }

    var calendarSpacesCount: Int {
        numberOfRows * daysOfWeek.count
    }

    var firstDayOfWeekInMonth: Int {
        guard let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: displayedMonth)) else {
            return 0
        }
        let weekday = calendar.component(.weekday, from: firstDayOfMonth)
        let offset = calendar.firstWeekday - 1
        return (weekday + 6 - offset) % daysOfWeek.count
    }

    var daysInMonth: Int {
        guard let range = calendar.range(of: .day, in: .month, for: displayedMonth) else {
            return 31
        }
        return range.count
    }

    @Published var selectedDate: Date
    @Published var displayedMonth: Date
    @Published var selectedIndex: Int

    public init(
        selectedDate: Date,
        specialDates: [MarkedDate]
    ) {
        self.selectedDate = selectedDate
        self.displayedMonth = Date()
        self.specialDates = specialDates
        self.selectedIndex = 0
        self.numberOfRows = 6 // Default value in iOS Calendar

        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = .current
        calendar.locale = .current

        let startDate = calendar.date(byAdding: .year, value: -2, to: Date()) ?? Date()
        let endDate = calendar.date(byAdding: .year, value: 2, to: Date()) ?? Date()

        self.calendar = calendar
        self.closeRange = startDate...endDate
    }

    func nextMonth() {
        changeMonth(by: 1)
    }

    func lastMonth() {
        changeMonth(by: -1)
    }

    func generateDate(at index: Int) -> (date: Date, markedDate: MarkedDate?, isEnabled: Bool) {
        let dayOffset = index - firstDayOfWeekInMonth
        let date = displayedMonth.day(dayOffset + 1, from: calendar)
        let specialDate = findSpecialDate(for: date)
        let isEnabled = dayOffset >= 0 && dayOffset < daysInMonth // dates from last/next month

        return (date, specialDate, isEnabled)
    }

    private func findSpecialDate(for date: Date) -> MarkedDate? {
        specialDates.first(where: { [weak self] specialDate in
            guard let self else { return false }

            return self.calendar.isDate(specialDate.date, equalTo: date, toGranularity: .day)
        })
    }

    private func changeMonth(by increment: Int) {
        guard let newMonth = calendar.date(byAdding: .month, value: increment, to: displayedMonth),
              let newMonthStart = calendar.date(from: calendar.dateComponents([.year, .month], from: newMonth)) else {
            print("Failed to calculate new month")
            return
        }

        if closeRange.contains(newMonthStart) {
            displayedMonth = newMonth
            selectedIndex += increment
        }
    }
}

extension MarkedCalendarViewModel {
    static func make(
        selectedDate: Date,
        specialDates: [MarkedDate]
    ) -> MarkedCalendarViewModel {
        .init(
            selectedDate: selectedDate,
            specialDates: specialDates
        )
    }
}

