//
//  ActiveCircleView.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 04.07.2023.
//

import SwiftUI

struct ActiveCircleView: View {
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
}

struct ControlCircleView_Previews: PreviewProvider {
    static var plug : () -> Void = {  }
    
    static var previews: some View {
        ActiveCircleView(tempo: .constant(80), bigCircleDiameter: 350)
            .environmentObject(DataManager())
    }
}
