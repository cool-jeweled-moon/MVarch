//
//  Item.swift
//  MVarch
//
//  Created by Борис Анели on 03.04.2025.
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
