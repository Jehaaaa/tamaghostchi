//
//  SoundManager.swift
//  Tamaghostchi
//
//  Created by Vincent Junior Halim on 26/05/24.
//

import Foundation
import AVFoundation

class SoundManager {
    static let instance = SoundManager()
    
    private var players: [SoundOptions: AVAudioPlayer] = [:]
    private let queue = DispatchQueue(label: "com.example.SoundManagerQueue")
    
    private init() {
        preloadSounds()
    }
    
    func preloadSounds() {
        for option in SoundOptions.allCases {
            guard let url = Bundle.main.url(forResource: option.rawValue, withExtension: "mp3") else { continue }
            queue.async {
                do {
                    let player = try AVAudioPlayer(contentsOf: url)
                    player.prepareToPlay()
                    player.volume = 1.0
                    self.players[option] = player
                } catch let error {
                    print("Error loading sound \(option.rawValue): \(error.localizedDescription)")
                }
            }
        }
    }
    
    func playSound(sound: SoundOptions) {
        queue.async {
            guard let player = self.players[sound] else { return }
            player.currentTime = 0
            player.play()
        }
    }
}

enum SoundOptions: String, CaseIterable {
    case yay
    case eating
    case jumpscare
    case coin
}
