//
//  Helper.swift
//  Tamaghostchi
//
//  Created by Vincent Junior Halim on 21/05/24.
//

import Foundation

func calcTimeSince(data: Date)->Int{
    let seconds = Int(-data.timeIntervalSinceNow)
    return seconds
}
