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
    let now = Date()
    let calendar = Calendar.current
    let year: Int
    let month: Int
    let day: Int
    let weekday: Int
    let startWeekday: Int
    let daysInMonth: Int
    var monthCalendar: [Days] = [Days]()
    
    init() {
        year = calendar.component(.year, from: now)
        month = calendar.component(.month, from: now)
        day = calendar.component(.day, from: now)
        weekday = calendar.component(.weekday, from: now)
        let x = (weekday - day % 7) % 7
        startWeekday = x >= 0 ? x + 1 : x + 8
        daysInMonth = calendar.daysInMonth(for: now)!
        monthCalendar = getMonthCalendar(offset: 0)
    }
    
    func getMonthCalendar(offset: Int) -> [Days] {
        var dayCalendar = [Days]()
        let target = calendar.date(byAdding: .month, value: offset, to: now)!
        let daysCount = calendar.daysInMonth(for: target)!
        let weekday = calendar.component(.weekday, from: target)
        let x = (weekday - day % 7) % 7
        let start = x >= 0 ? x + 1 : x + 8
        for i in 1...42 {
            if i < start {
                dayCalendar.append(Days(day: 0))
            }
            else if i < start + daysCount {
                dayCalendar.append(Days(day: i - start + 1))
            }
            else {
                dayCalendar.append(Days(day: 0))
            }
        }
        return dayCalendar
    }
}

extension Calendar {
    func daysInMonth(for date:Date) -> Int? {
        return range(of: .day, in: .month, for: date)?.count
    }
}

struct Days: Identifiable {
    let id = UUID()
    let day: Int
}

let weekdays = Calendar.current.shortWeekdaySymbols

struct CalendarView: View {
    @Environment(\.modelContext) private var context
    @Query private var dailyNotes: [DailyNote]
    
    let today = Today()
    let columns: [GridItem] = Array(repeating: .init(.fixed(48)), count: 7)
    @State var monthOffset: Int = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 254 / 255, green: 204 / 255, blue: 102 / 255, opacity: 0.2)
                    .ignoresSafeArea()
                VStack {
                    HStack {
                        Button(action: {
                            monthOffset -= 1
                        }) {
                            Text("<")
                        }
                        Spacer()
                            .frame(width: 80)
                        Text(getTargetYear())
                            .frame(width: 96)
                        Text("/")
                        Text(getTargetMonth())
                            .frame(width: 48)
                        Spacer()
                            .frame(width: 80)
                        Button(action: {
                            monthOffset += 1
                        }) {
                            Text(">")
                        }
                        
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
                        ForEach(today.getMonthCalendar(offset: monthOffset)) { day in
                            if day.day != 0 {
                                @State var dayString = String(getTargetMonth()) + " / " + String(day.day)
                                NavigationLink {
                                    TodayView(day: $dayString)
                                } label: {
                                    ZStack {
                                        Text("\(day.day)")
                                            .frame(width: 48, height: 64, alignment: .top)
                                            .foregroundColor(.black)
                                            .background(.white)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 4)
                                                    .stroke(Color.gray, lineWidth: 1)
                                            )
                                        VStack {
                                            Spacer()
                                                .frame(height: 16)
                                            Text("")
                                        }
                                    }
                                }
                            }
                            else {
                                Text("")
                                    .frame(height: 64)
                            }
                        }
                    }
                }
            }
        }
    }
    private func getTargetMonth() -> String{
        let target = Calendar.current.date(byAdding: .month, value: monthOffset, to: today.now)!
        return String(Calendar.current.component(.month, from: target))
    }
    private func getTargetYear() -> String {
        let target = Calendar.current.date(byAdding: .month, value: monthOffset, to: today.now)!
        return String(Calendar.current.component(.year, from: target))
    }
}

#Preview {
    CalendarView()
}
