//
//  ControlCircleView.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 04.07.2023.
//

import SwiftUI

struct ControlCircleView: View {
    @Binding var tempo: Double
    
    @EnvironmentObject private var dataManager: DataManager

    @StateObject private var viewModel = ControlCircleViewModel()
    @State private var lastAngle: CGFloat = 0
    @State private var counter: CGFloat = 0
    
    let bigCircleDiameter: CGFloat
    
    var body: some View {
        Circle()
            .foregroundColor(.white)
            .frame(width: bigCircleDiameter)
            .gesture(DragGesture()
                .onChanged{ value in
                    viewModel.rotationControlLogic(value, diameter: bigCircleDiameter)
                }
                .onEnded { v in
                    self.counter = 0
                })
            .onAppear {
                viewModel.dataManager = dataManager
            }
    }
    
//    private func rotationControlLogic(_ value: DragGesture.Value) {
//        let deltaX = value.location.x - bigCircleDiameter / 2
//        let deltaY = bigCircleDiameter / 2 - value.location.y
//        var angle = atan2(deltaX, deltaY) * 180 / .pi
//        if (angle < 0) {
//            angle += 360
//        }
//
//        let theta = self.lastAngle - angle
//        self.lastAngle = angle
//
//        if (abs(theta) < 20) {
//            self.counter += theta
//        }
//
//        if self.counter > 20 && tempo > 40 {
//            tempo -= 1
//        } else if self.counter < -20 && tempo < 300{
//            tempo += 1
//        }
//
//        if (abs(self.counter) > 20) {
//            self.counter = 0
//        }
//    }
}

struct ControlCircleView_Previews: PreviewProvider {
    static var plug : () -> Void = {  }
    
    static var previews: some View {
        ControlCircleView(tempo: .constant(80), bigCircleDiameter: 350)
            .environmentObject(DataManager())
    }
}
