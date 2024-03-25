//
//  MarkedCalendar.swift
//  MarkedCalendar
//
//  Created by Nikol Lazarte on 21/03/24.
//

import SwiftUI

struct MarkedCalendar: View {
    private enum Sizes {
        static let spacing: CGFloat = 12
        static let maxHeight: CGFloat = 260
    }

    @StateObject var viewModel: MarkedCalendarViewModel

    public init(
        selectedDate: Date,
        specialDates: [MarkedDate]
    ) {
        self._viewModel = StateObject(
            wrappedValue:
                MarkedCalendarViewModel.make(
                    selectedDate: selectedDate,
                    specialDates: specialDates
                )
        )
    }

    public var body: some View {
        VStack(spacing: Sizes.spacing) {
            HStack {
                Button(action:viewModel.lastMonth) {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .foregroundColor(viewModel.canMoveToPreviousMonth ? Color.blue : Color.gray)
                        .aspectRatio(contentMode: .fit)
                        .frame(height: Sizes.spacing)
                }
                .disabled(!viewModel.canMoveToPreviousMonth)

                Spacer()

                Text(viewModel.displayedMonth.monthYear)
                    .font(.caption)
                    .foregroundColor(.black)

                Spacer()

                Button(action:viewModel.nextMonth) {
                    Image(systemName: "chevron.right")
                        .resizable()
                        .foregroundColor(viewModel.canMoveToNextMonth ? Color.blue : Color.gray)
                        .aspectRatio(contentMode: .fit)
                        .frame(height: Sizes.spacing)
                }
                .disabled(!viewModel.canMoveToNextMonth)
            }
            .padding(.horizontal, Constants.Spacing.xxsmall)

            HStack {
                ForEach(viewModel.daysOfWeek, id: \.self) { day in
                    Text(day)
                        .frame(maxWidth: .infinity)
                        .font(.callout)
                        .foregroundColor(Color.gray)
                }
            }
            .padding(.bottom, Constants.Spacing.xxxsmall)

            MonthView(viewModel: viewModel)
                .frame(maxHeight: Sizes.maxHeight, alignment: .top)
        }
        .padding(Sizes.spacing)
    }
}
