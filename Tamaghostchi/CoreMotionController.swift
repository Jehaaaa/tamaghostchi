//
//  CoreMotionController.swift
//  TestTamago
//
//  Created by Vincent Junior Halim on 23/05/24.
//

import Foundation
import CoreMotion

class CoreMotionController: ObservableObject {
    private var motionManager: CMMotionManager
    @Published var currentAcceleration: CMAcceleration = CMAcceleration(x: 0, y: 0, z: 0)
    @Published var previousAcceleration: CMAcceleration?
    init() {
        motionManager = CMMotionManager()
        motionManager.accelerometerUpdateInterval = 1.5
        startAccelerometerUpdates()
    }
    
    private func startAccelerometerUpdates() {
        if motionManager.isAccelerometerAvailable {
            motionManager.startAccelerometerUpdates(to: .main) { [weak self] (data, error) in
                if let data = data {
                    self?.updateAcceleration(data.acceleration)
                }
            }
        }
    }
    
    private func updateAcceleration(_ newAcceleration: CMAcceleration) {
        previousAcceleration = currentAcceleration
        currentAcceleration = newAcceleration
        compareAccelerations(previous: previousAcceleration, current: currentAcceleration)
    }
    
    private func compareAccelerations(previous: CMAcceleration?, current: CMAcceleration){
        guard let previous = previous else { return }
        
        let threshold: Double = 0.1 // Define a threshold for significant change
        
        let deltaX = abs(current.x - previous.x)
        let deltaY = abs(current.y - previous.y)
        if deltaX > threshold && deltaY > 0.1 {
            print("DEBUG : FUN++")
            isTimanging = true
        }
    }
    
    deinit {
        motionManager.stopAccelerometerUpdates()
    }
}
