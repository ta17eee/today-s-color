//
//  TodayView.swift
//  today-s-color
//
//  Created by 高野　泰生 on 2024/11/17.
//

import SwiftUI

struct TodayView: View {
    var today = Today()
    let ratingColor: [Color] = [Color(red: 196 / 255, green: 112 / 255, blue: 34 / 255),
                                Color(red: 192 / 255, green: 192 / 255, blue: 192 / 255),
                                Color(red: 1, green: 215 / 255, blue: 0)]
    let icons = ["🙂", "😊", "🤪", "😥", "😵‍💫", "😡"]
    
    var body: some View {
        ZStack {
            Color(red: 254 / 255, green: 204 / 255, blue: 102 / 255, opacity: 0.2)
                .ignoresSafeArea()
            VStack {
                Text("\(today.month) / \(today.day)")
                    .font(.largeTitle)
                Spacer()
                    .frame(height: 64)
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
                        ForEach(ratingColor, id: \.self) { color in
                            Spacer()
                            color
                                .frame(width: 64, height: 32)
                            Spacer()
                        }
                        Spacer()
                            .frame(width: 32)
                    }
                }
                Spacer()
                    .frame(height: 32)
                HStack {
                    Spacer()
                        .frame(width: 16)
                    Text("今日の気分")
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
                        ForEach(icons, id: \.self) { icon in
                            Spacer()
                            Text(icon)
                            Spacer()
                        }
                        Spacer()
                            .frame(width: 32)
                    }
                }
                Spacer()
            }
        }
    }
}

#Preview {
    TodayView()
}
