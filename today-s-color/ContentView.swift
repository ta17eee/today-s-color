//
//  ContentView.swift
//  today-s-color
//
//  Created by 高野　泰生 on 2024/11/17.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query private var dailyNotes: [DailyNote]
    
    let today = Today()

    var body: some View {
        @State var todayString = String(today.month) + " / " + String(today.day)
        TabView {
            TodayView(day: $todayString)
                .tabItem {
                    Image(systemName: "pencil.line")
                    Text("きょう")
                }
            CalendarView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("カレンダー")
                }
        }
        .accentColor(.green)
    }
//        private func addItem() {
//            withAnimation {
//                let newItem = Item(timestamp: Date())
//                modelContext.insert(newItem)
//            }
//        }
//    
//        private func deleteItems(offsets: IndexSet) {
//            withAnimation {
//                for index in offsets {
//                    modelContext.delete(items[index])
//                }
//            }
//        }
}

#Preview {
    ContentView()
        .modelContainer(for: DailyNote.self, inMemory: true)
}
