//
//  MetronomeViewPrototype.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 01.06.2023.
//

import SwiftUI

struct ControlWheelView: View {
    
    @Binding var tempo: Double 
    
    let bigCircleDiameter: CGFloat
    
    let startMetronome: () -> Void
    
    private let backgroundColor = UIColor(named: "BackgroundColor") ?? .systemGray5
    
    var body: some View {
        
        ZStack {
            Color(backgroundColor)
                .ignoresSafeArea()
            
            TempoControlWheel(
                bigCircleDiameter: bigCircleDiameter,
                backgroundColor: backgroundColor,
                tempo: $tempo
            )
            
            ControlButtonsView(
                tempo: $tempo,
                startMetronome: startMetronome,
                backgroundColor: backgroundColor,
                bigCircleDiameter: bigCircleDiameter
            )
            
            TempoText(
                tempo: $tempo
            )
        }
    }
}

struct ControlWheelView_Previews: PreviewProvider {
    static var plug : () -> Void = {  }
    
    static var previews: some View {
        ControlWheelView(
            tempo: .constant(80),
            bigCircleDiameter: 350,
            startMetronome: plug
        )
        .environmentObject(DataManager())

    }
}

struct TempoControlWheel: View {
    
    let bigCircleDiameter: CGFloat
    let backgroundColor: UIColor
    
    @Binding var tempo: Double
    
    private var centerHoleDiameter: CGFloat {
        (bigCircleDiameter / 3) * 1.3
    }

    var body: some View {
        ZStack {
            ControlCircleView(
                tempo: $tempo, bigCircleDiameter: bigCircleDiameter
            )
            
            Circle()
                .foregroundColor(Color(backgroundColor))
                .frame(width: centerHoleDiameter)
        }
    }
}

struct TempoText: View {
    @Binding var tempo: Double
    
    var body: some View {
        Text(tempo.formatted())
            .frame(width: 350, height: 350)
            .font(.custom("Arial Rounded MT Bold", size: 70))
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
    }
}
