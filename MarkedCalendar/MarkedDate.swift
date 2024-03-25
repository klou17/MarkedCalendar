//
//  MarkedDate.swift
//  MarkedCalendar
//
//  Created by Nikol Lazarte on 21/03/24.
//

import Foundation
import SwiftUI

public struct MarkedDate {
    public let date: Date
    public let icon: AnyView

    public init(date: Date, icon: AnyView) {
        self.date = date
        self.icon = icon
    }
}

public extension [MarkedDate] {
    static func mockData() -> [MarkedDate] {
        [
            MarkedDate(date: Date().today, icon: AnyView(Circle().frame(width: 6, height: 6))),
            MarkedDate(date: Date().tomorrow, icon: AnyView(Circle().frame(width: 6, height: 6))),
            MarkedDate(date: Date().add(.day, value: 12) ?? Date(), icon: AnyView(Circle().frame(width: 6, height: 6)))
        ]
    }
}
