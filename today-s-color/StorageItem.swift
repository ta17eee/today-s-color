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
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}

@Model
final class DailyNote {
//    var frame: Color
//    var color: Color
    var icon: String
    
    init() {
        icon = ""
    }
}
