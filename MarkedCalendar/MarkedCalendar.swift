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

public struct StylesKey: EnvironmentKey {
    public static var defaultValue: Styles = Styles()
}

public extension EnvironmentValues {
    var datePickerTheme: Styles {
        get { self[StylesKey.self] }
        set { self[StylesKey.self] = newValue }
    }
}

public extension View {
    func datePickerTheme(_ theme: Styles) -> some View {
        self.environment(\.datePickerTheme, theme)
    }
    
    func datePickerTheme(
        main: Styles.Main = .init()
    ) -> some View {
        self.environment(\.datePickerTheme, Styles(main: main))
    }
}

public struct Styles {
    public let main: Main
    
    public init(main: Styles.Main = .init()) {
        self.main = main
    }
}


public extension Styles {
    struct Main {
        public let accentColor: Color
        public let monthTitle: Color
        public let daysName: Color
        public let daysNumbers: Color
        public let previousDaysNumber: Color
        public let backgroundStyle: BackgroundStyle
        
        public init(accentColor: Color = .blue,
                    monthTitle: Color = Color(UIColor.label),
                    daysName: Color = .gray,
                    daysNumbers: Color = Color(UIColor.label),
                    previousDaysNumber: Color = .gray,
                    backgroundStyle: BackgroundStyle = .background) {
            
            self.accentColor = accentColor
            self.monthTitle = monthTitle
            self.daysName = daysName
            self.daysNumbers = daysNumbers
            self.previousDaysNumber = previousDaysNumber
            self.backgroundStyle = backgroundStyle
            
        }
    }
}
