//
//  Helper.swift
//  Tamaghostchi
//
//  Created by Vincent Junior Halim on 23/05/24.
//

import Foundation
import ARKit
import RealityKit
import AVFoundation


func saveStatus(hungerValue:Double, funValue:Double, coinValue:Double){
    let defaults = UserDefaults.standard
    defaults.set(Double(hungerValue),forKey: "hunger")
    defaults.set(Double(funValue),forKey: "fun")
    defaults.set(Double(coinValue),forKey: "coin")
}

func getHungerValue()->Double{
    let defaults = UserDefaults.standard
    return defaults.double(forKey: "hunger")
}

func getFunValue()->Double{
    let defaults = UserDefaults.standard
    return defaults.double(forKey: "fun")
}

func getCoinValue()->Double{
    let defaults = UserDefaults.standard
    return defaults.double(forKey: "coin")
}
// TODO: pindahin ke tempat lain biar gk jadi global variable, pindahin ke atas page bg
var isTimanging = false

var isJumpscare = false


