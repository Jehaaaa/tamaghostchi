//
//  StatusData.swift
//  Tamaghostchi
//
//  Created by Vincent Junior Halim on 21/05/24.
//

import Foundation
import SwiftData

@Model
class StatusData{
    var hungerValue: Double
    var funValue: Double
    var coinValue: Double
    
    init() {
        self.hungerValue = 0.4
        self.funValue = 0.2
        self.coinValue = 0
    }
}

