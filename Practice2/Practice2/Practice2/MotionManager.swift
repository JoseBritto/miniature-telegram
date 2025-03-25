//
//  MotionManager.swift
//  Practice2
//
//  Created by Jose Britto Saaji on 2025-03-25.
//

import Foundation
import SwiftUI
import CoreMotion

class MotionManager: ObservableObject {
    private let motionManager = CMMotionManager()
    
    @Published var accelerationX: Double = 0.0
    @Published var accelerationY: Double = 0.0
    @Published var accelerationZ: Double = 0.0
    
    init() {
        if motionManager.isAccelerometerAvailable {
            motionManager.startAccelerometerUpdates(to: .main) { [weak self] (data, error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else if let data = data {
                    self?.accelerationX = data.acceleration.x
                    self?.accelerationY = data.acceleration.y
                    self?.accelerationZ = data.acceleration.z
                }
            }
        } else {
            print("Accelerometer not available")
        }
    }
}

