//
//  ControlCircleView.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 04.07.2023.
//

import SwiftUI

struct ControlCircleView: View {
    let bigCircleDiameter: CGFloat
    
    @Binding var tempo: Double
    
    @State private var lastAngle: CGFloat = 0
    @State private var counter: CGFloat = 0
    
    var body: some View {
#warning("deal with shadow")
        Circle()
            .foregroundColor(.white)
//            .shadow(color: .gray, radius: 1)
            .frame(width: bigCircleDiameter)
            .gesture(DragGesture()
                .onChanged{ value in
                    rotationControlLogic(value)
                }
                .onEnded { v in
                    self.counter = 0
                })
    }
    
    private func rotationControlLogic(_ value: DragGesture.Value) {
        let deltaX = value.location.x - bigCircleDiameter / 2
        let deltaY = bigCircleDiameter / 2 - value.location.y
        var angle = atan2(deltaX, deltaY) * 180 / .pi
        if (angle < 0) {
            angle += 360
        }
        
        let theta = self.lastAngle - angle
        self.lastAngle = angle
        
        if (abs(theta) < 20) {
            self.counter += theta
        }
        
        if self.counter > 20 && tempo > 40 {
            tempo -= 1
        } else if self.counter < -20 && tempo < 300{
            tempo += 1
        }
        
        if (abs(self.counter) > 20) {
            self.counter = 0
        }
    }
}
