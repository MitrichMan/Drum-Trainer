//
//  ControlCircleViewModel.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 04.07.2023.
//

import SwiftUI

class ControlCircleViewModel: ObservableObject {
    var dataManager = DataManager()

    
    private var lastAngle: CGFloat = 0
    private var counter: CGFloat = 0
    
    func rotationControlLogic(_ value: DragGesture.Value, diameter: CGFloat) {
        let deltaX = value.location.x - diameter / 2
        let deltaY = diameter / 2 - value.location.y
        var angle = atan2(deltaX, deltaY) * 180 / .pi
        if (angle < 0) {
            angle += 360
        }
        
        let theta = self.lastAngle - angle
        self.lastAngle = angle
        
        if (abs(theta) < 20) {
            self.counter += theta
        }
        
        if self.counter > 20 && dataManager.defaultSettings.tempo > 40 {
            dataManager.defaultSettings.tempo -= 1
        } else if self.counter < -20 && dataManager.defaultSettings.tempo < 300{
            dataManager.defaultSettings.tempo += 1
        }
        
        if (abs(self.counter) > 20) {
            self.counter = 0
        }
    }
}
