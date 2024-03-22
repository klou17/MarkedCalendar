//
//  MarkedDate.swift
//  MarkedCalendar
//
//  Created by Nikol Lazarte on 21/03/24.
//

import Foundation

public struct MarkedDate {
    public let date: Date
    public let ordersAmount: Int

    public var areManyOrders: Bool {
        ordersAmount > 3
    }

    public init(date: Date, ordersAmount: Int) {
        self.date = date
        self.ordersAmount = ordersAmount
    }
}

public extension [MarkedDate] {
    static func mockData() -> [MarkedDate] {
        [
            MarkedDate(date: Date().today, ordersAmount: 4),
            MarkedDate(date: Date().tomorrow , ordersAmount: 2),
            MarkedDate(date: Date().add(.day, value: 12) ?? Date(), ordersAmount: 2)
        ]
    }
}
