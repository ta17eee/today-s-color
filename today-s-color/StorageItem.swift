//
//  Item.swift
//  today-s-color
//
//  Created by 高野　泰生 on 2024/11/17.
//

import Foundation
import SwiftData
import SwiftUICore

@Model
final class DailyNote: ObservableObject {
    #Index<DailyNote>([\.day])
    
    var day: Int
    var frame: ColorData
    var color: ColorData
    var icon: String
    var item: [Note]
    
    init(day: Today = Today(), frame: ColorData, color: ColorData, icon: String) {
        self.day = day.year * 10000 + day.month * 100 + day.day
        self.frame = frame
        self.color = color
        self.icon = icon
        self.item = []
    }
    
    func setFrame(_ frame: ColorData) {
        self.frame = frame
    }
    func setColor(_ color: ColorData) {
        self.color = color
    }
    func setIcon(_ icon: String) {
        self.icon = icon
    }
}

struct Note: Identifiable, Codable {
    var id = UUID()
    var type: String
    var value: String
    
    init(type: String, value: String) {
        self.type = type
        self.value = value
    }
}

struct ColorData: Identifiable , Codable {
    var id = UUID()
    var red: Int
    var green: Int
    var blue: Int
    var opacity: Double
    
    init(red: Int, green: Int, blue: Int, opacity: Double = 1) {
        self.red = red
        self.green = green
        self.blue = blue
        self.opacity = opacity
    }
    
    func getColor() -> Color {
        return Color(red: Double(red) / 255.0, green: Double(green) / 255, blue: Double(blue) / 255, opacity: opacity)
    }
}
