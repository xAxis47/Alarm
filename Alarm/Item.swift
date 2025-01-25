//
//  Item.swift
//  Alarm
//
//  Created by Kawagoe Wataru on 2025/01/25.
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