//
//  Date+Extensions.swift
//  MarkedCalendar
//
//  Created by Nikol Lazarte on 21/03/24.
//

import Foundation

extension Date {
    var day: String {
        self.formatted(
            .dateTime
            .day(.twoDigits)
        )
    }

    var monthYear: String {
        self.formatted(
            .dateTime
                .month()
                .year()
        )
    }

    var today: Date {
        Calendar.current.startOfDay(for: self)
    }

    var tomorrow: Date {
        let today = self.add(.day, value: 1) ?? Date()
        return Calendar.current.startOfDay(for: today)
    }

    func year(from calendar: Calendar) -> Int {
        calendar.component(.year, from: self)
    }

    func month(from calendar: Calendar) -> Int {
        calendar.component(.month, from: self)
    }

    func day(_ day: Int, from calendar: Calendar) -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = year(from: calendar)
        dateComponents.month = month(from: calendar)
        dateComponents.day = day
        return calendar.date(from: dateComponents) ?? Date()
    }

    func add(_ component: Calendar.Component, in calendar: Calendar = .current, value: Int) -> Date? {
        calendar.date(byAdding: component, value: value, to: self)
    }

    func isEqual(with date: Date) -> Bool {
        let calendar = Calendar.autoupdatingCurrent
        return calendar.isDate(self, inSameDayAs: date)
    }
}

