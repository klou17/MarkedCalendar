//
//  ContentView.swift
//  MarkedCalendar
//
//  Created by Nikol Lazarte on 21/03/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MarkedCalendar(
            selectedDate: Date(),
            specialDates: .mockData()
        )
    }
}

#Preview {
    ContentView()
}
