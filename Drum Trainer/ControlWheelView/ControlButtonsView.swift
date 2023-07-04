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
        Button(action: startMetronome) {
            Image(systemName: "playpause.fill")
                .font(.largeTitle)
                .foregroundColor(Color(backgroundColor))
                .frame(width: 70, height: 70)
        }
        .offset(y: -bigCircleDiameter / 3)
        
        //            Image(systemName: "playpause.fill")
        //                .font(.title)
        //                .foregroundColor(Color(backgroundColor))
        //                .offset(y: bigCircleDiameter / 3)
        
        Button(action: tempoMinus) {
            Image(systemName: "minus")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(Color(backgroundColor))
                .frame(width: 50, height: 50)
        }
        .offset(x: -bigCircleDiameter / 3)
        
        
        Button(action: tempoPlus) {
            Image(systemName: "plus")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(Color(backgroundColor))
                .frame(width: 50, height: 50)

        }
        .offset(x: bigCircleDiameter / 3)
    }
    
    private func tempoMinus() {
        tempo -= 1
    }
    
    private func tempoPlus() {
        tempo += 1
    }
}
