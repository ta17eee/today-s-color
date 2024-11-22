//
//  TodayView.swift
//  today-s-color
//
//  Created by 高野　泰生 on 2024/11/17.
//
import SwiftData
import SwiftUI

struct TodayView: View {
    @Query private var dailyNotes: [DailyNote]
    @Environment(\.modelContext) private var context
    
    @Binding var day: String
    
    var today = Today()
    let frame: [ColorData] = [ColorData(red: 196, green: 112, blue: 34),
                              ColorData(red: 192, green: 192, blue: 192),
                              ColorData(red: 255, green: 215, blue: 0)]
//    var colors: [Color] = [.red, .green, .blue, .orange, .yellow, .purple, .gray]
    var colors: [ColorData] = [ColorData(red: 232, green: 57, blue: 41),
                               ColorData(red: 255, green: 241, blue: 0),
                               ColorData(red: 80, green: 232, blue: 41),
                               ColorData(red: 41, green: 134, blue: 232),
                               ColorData(red: 112, green: 41, blue: 232),
                               ColorData(red: 232, green: 41, blue: 189),
                               ColorData(red: 128, green: 128, blue: 128)]
    var icons = ["🙂", "😊", "🤪", "😥", "😵‍💫", "😡"]
    @State var textfield: String = ""
    @State var todayNote = DailyNote(frame: ColorData(red: 255, green: 255, blue: 255, opacity: 0), color: ColorData(red: 255, green: 255, blue: 255, opacity: 0), icon: "")
    
    var body: some View {
        ZStack {
            Color(red: 254 / 255, green: 204 / 255, blue: 102 / 255, opacity: 0.2)
                .ignoresSafeArea()
            VStack {
                Text(day)
                    .font(.largeTitle)
                Spacer()
                    .frame(height: 16)
                HStack {
                    Spacer()
                        .frame(width: 16)
                    Text("今日の評価")
                    Spacer()
                    
                    Spacer()
                        .frame(width: 16)
                }
                ZStack {
                    HStack {
                        Spacer()
                            .frame(width: 16)
                        RoundedRectangle(cornerRadius: 8)
                            .frame(height: 64)
                            .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.4, opacity: 0.1))
                        Spacer()
                            .frame(width: 16)
                    }
                    HStack {
                        Spacer()
                            .frame(width: 32)
                        ForEach(frame) { item in
                            Spacer()
                            Button(action: {
                                todayNote.setFrame(item)
                                store()
                            }) {
                                item.getColor()
                                    .frame(width: 64, height: 32)
                            }
                            Spacer()
                        }
                        Spacer()
                            .frame(width: 32)
                    }
                }
                Spacer()
                    .frame(height: 8)
                HStack {
                    Spacer()
                        .frame(width: 16)
                    Text("今日の色")
                    Spacer()
                    Button(action: {
                        
                    }) {
                        Text("編集")
                    }
                    Spacer()
                        .frame(width: 16)
                }
                ZStack {
                    HStack {
                        Spacer()
                            .frame(width: 16)
                        RoundedRectangle(cornerRadius: 8)
                            .frame(height: 64)
                            .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.4, opacity: 0.1))
                        Spacer()
                            .frame(width: 16)
                    }
                    HStack {
                        Spacer()
                            .frame(width: 32)
                        ForEach(colors) { item in
                            Spacer()
                            Button(action: {
                                todayNote.setColor(item)
                                store()
                            }) {
                                ZStack {
//                                    if dailyNotes.count > 0 {
//                                        let index = dailyNotes.first(where: {
//                                            $0.id == today.getDayID()
//                                        })
//                                    }
//                                    if item == todayNote.color {
//                                        
//                                    }
                                    Circle()
                                        .foregroundColor(item.getColor())
                                        .frame(height: 32)
                                }
                            }
                            Spacer()
                        }
                        Spacer()
                            .frame(width: 32)
                    }
                }
                Spacer()
                    .frame(height: 8)
                HStack {
                    Spacer()
                        .frame(width: 16)
                    Text("今日の気分")
                    Spacer()
                    Button(action: {
                        
                    }) {
                        Text("編集")
                    }
                    Spacer()
                        .frame(width: 16)
                }
                ZStack {
                    HStack {
                        Spacer()
                            .frame(width: 16)
                        RoundedRectangle(cornerRadius: 8)
                            .frame(height: 64)
                            .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.4, opacity: 0.1))
                        Spacer()
                            .frame(width: 16)
                    }
                    HStack {
                        Spacer()
                            .frame(width: 32)
                        ForEach(icons, id: \.self) { icon in
                            Spacer()
                            Button(action: {
                                todayNote.setIcon(icon)
                                store()
                            }) {
                                Text(icon)
                            }
                            Spacer()
                        }
                        Spacer()
                            .frame(width: 32)
                    }
                }
                Spacer()
                    .frame(height: 8)
                Text("できごと")
                HStack {
                    Spacer()
                        .frame(width: 16)
                    ScrollView {
                        ForEach(todayNote.item) { note in
                            if note.type == "text" {
                                Text("\(note.value)")
                                    .padding(.all, 1.0)
                                    .background(Color(red: 0.9, green: 0.9, blue: 0.9, opacity: 0.5))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 1)
                                            .stroke(Color.gray, lineWidth: 1)
                                    )
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 2)
                            .stroke(Color.gray, lineWidth: 2)
                        )
                    .background(.white)
                    Spacer()
                        .frame(width: 16)
                }
                Spacer()
                HStack { // 確認用
                    Rectangle()
                        .frame(width: 16, height: 16)
                        .foregroundColor(todayNote.frame.getColor())
                    Circle()
                        .frame(width: 16, height: 16)
                        .foregroundColor(todayNote.color.getColor())
                    Text("\(todayNote.icon)")
                }
                HStack {
                    Spacer()
                        .frame(width: 16)
                    TextField("今日あったこと", text: $textfield)
                        .background(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 2)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                    Button(action: {
                        todayNote.addItem(Note(type: "text", value: textfield))
                        textfield = ""
                        store()
                    }) {
                        Image(systemName: "paperplane.fill")
                    }
                    Spacer()
                        .frame(width: 16)
                }
                Spacer()
                    .frame(height: 16)
            }
        }
    }
    
    private func store() {
        context.insert(todayNote)
    }
}

#Preview {
    @Previewable @State var string = "MM / dd"
    TodayView(day: $string)
        .modelContainer(for: DailyNote.self, inMemory: true)
}
