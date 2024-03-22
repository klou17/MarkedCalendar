//
//  MonthView.swift
//  MarkedCalendar
//
//  Created by Nikol Lazarte on 21/03/24.
//

import SwiftUI

struct MonthView: View {
    @ObservedObject var viewModel: MarkedCalendarViewModel

    var columns: [GridItem] {
        Array(repeating: .init(.flexible()), count: viewModel.daysOfWeek.count)
    }

    var body: some View {
        LazyVGrid(columns: columns, spacing: Constants.Spacing.xxxxsmall) {
            ForEach(0..<viewModel.calendarSpacesCount, id: \.self) { index in
                gridCellView(at: index)
            }
        }
    }

    @ViewBuilder
    func gridCellView(at index: Int) -> some View {
        let data = viewModel.generateDate(at: index)

        DayView(
            date: data.date,
            closeRange: viewModel.closeRange,
            isSelected: viewModel.selectedDate.isEqual(with: data.date),
            isToday: viewModel.calendar.isDateInToday(data.date),
            markedDate: data.markedDate,
            calendar: viewModel.calendar
        )
        .disabled(!data.isEnabled)
        .onTapGesture {
            if data.isEnabled {
                viewModel.selectedDate = data.date
            }
        }
    }
}
