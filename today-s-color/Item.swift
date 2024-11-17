//
//  Item.swift
//  today-s-color
//
//  Created by 高野　泰生 on 2024/11/17.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
