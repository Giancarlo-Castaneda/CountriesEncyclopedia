//
//  Item.swift
//  CountriesEncyclopedia
//
//  Created by Giancarlo Castañeda Garcia on 17/06/25.
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
