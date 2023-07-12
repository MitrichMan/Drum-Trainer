//
//  ControlButtonsView.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 04.07.2023.
//

import SwiftUI

struct ControlButtonsView: View {
    @Binding var tempo: Double
    
    let startMetronome: () -> Void
    
    let backgroundColor: UIColor
    let bigCircleDiameter: CGFloat
    
    var body: some View {
        ControlButton(
            buttonAction: startMetronome,
            backgroundColor: backgroundColor,
            name: "playpause.fill"
        )
        .offset(y: -bigCircleDiameter / 3)
        
        ControlButton(
            buttonAction: tempoMinus,
            backgroundColor: backgroundColor,
            name: "minus"
        )
        .offset(x: -bigCircleDiameter / 3)

        ControlButton(
            buttonAction: tempoPlus,
            backgroundColor: backgroundColor,
            name: "plus"
        )
        .offset(x: bigCircleDiameter / 3)
    }
    
    private func tempoMinus() {
        tempo -= 1
    }
    
    private func tempoPlus() {
        tempo += 1
    }
}

struct ControlButton: View {
    let buttonAction: () -> Void
    let backgroundColor: UIColor
    let name: String
    
    var body: some View {
        Button(action: buttonAction) {
            Image(systemName: name)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(Color(backgroundColor))
                .frame(width: 70, height: 70)

        }
    }
}
