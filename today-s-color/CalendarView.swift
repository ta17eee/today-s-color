//
//  CalendarVIw.swift
//  today-s-color
//
//  Created by 高野　泰生 on 2024/11/17.
//

import SwiftUI
import SwiftData
import Foundation

struct Today {
    var now = Date()
    let calendar = Calendar.current
    let year: Int
    let month: Int
    let day: Int
    let weekday: Int
    let startWeekday: Int
    let daysInMonth: Int
    let daysInLastMonth: Int
    let weeksInMonth: Int
    var monthCalendar: [Days] = [Days]()
    
    init() {
        year = calendar.component(.year, from: now)
        month = calendar.component(.month, from: now)
        day = calendar.component(.day, from: now)
        weekday = calendar.component(.weekday, from: now)
        let x = weekday - day % 7
        startWeekday = x % 7 > 0 ? x : x + 8
        daysInMonth = Calendar.current.daysInMonth(for: now)!
        daysInLastMonth = Calendar.current.daysInLastMonth(for: now)!
        weeksInMonth = Calendar.current.weeksInMonth(for: now)!
        monthCalendar = getMonthCalendar(weeks: weeksInMonth, start: startWeekday, days: daysInMonth)
    }
    
    func getMonthCalendar(weeks: Int, start: Int, days: Int) -> [Days] {
        var calendar = [Days]()
        for i in 1...(7 * weeks) {
            if i < start {
                calendar.append(Days(day: 0))
            }
            else if i < start + days {
                calendar.append(Days(day: i - start + 1))
            }
            else {
                calendar.append(Days(day: 0))
            }
        }
        return calendar
    }
}

extension Calendar {
    func daysInMonth(for date:Date) -> Int? {
        return range(of: .day, in: .month, for: date)?.count
    }
    func daysInLastMonth(for date: Date) -> Int? {
        let lastMonth = Calendar.current.date(byAdding: .month, value: -1, to: date)!
        return range(of: .day, in: .month, for: lastMonth)?.count
    }
    func weeksInMonth(for date:Date) -> Int? {
        return range(of: .weekOfMonth, in: .month, for: date)?.count
    }
}

struct Days: Identifiable {
    let id = UUID()
    let day: Int
}

let weekdays = Calendar.current.shortWeekdaySymbols

struct CalendarView: View {
    let today = Today()
    var columns: [GridItem] = Array(repeating: .init(.fixed(48)), count: 7)
    
    var body: some View {
        ZStack {
            Color(red: 254 / 255, green: 204 / 255, blue: 102 / 255, opacity: 0.2)
                .ignoresSafeArea()
            VStack {
                HStack {
                    Text(String(today.year))
                    Text("/")
                    Text(String(today.month))
                }
                .fontWeight(.bold)
                .font(.largeTitle)
                HStack {
                    ForEach(weekdays, id: \.self) { weekday in
                        if weekday == "Sun" {
                            Text(weekday)
                                .foregroundColor(Color.red)
                        }
                        else if weekday == "Sat" {
                            Text(weekday)
                                .foregroundColor(Color.blue)
                        }
                        else {
                            Text(weekday)
                        }
                    }
                    .frame(width: 48, height: 32, alignment: .center)
                }
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(today.monthCalendar) { day in
                        if day.day != 0 {
                            Text("\(day.day)")
                                .frame(width: 48, height: 64, alignment: .top)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                        }
                        else {
                            Text("")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CalendarView()
}
