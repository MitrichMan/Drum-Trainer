//
//  MetronomeViewPrototype.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 01.06.2023.
//

import SwiftUI

struct MetronomeViewPrototype: View {
    
    @Binding var tempo: Double 
    
    let bigCircleDiameter: CGFloat
    
    let startMetronome: () -> Void
    
    private let backgroundColor = UIColor(named: "BackgroundColor") ?? .systemGray5
    
    var body: some View {
        
        ZStack {
            Color(backgroundColor)
                .ignoresSafeArea()
            
            TempoControlDoughnut(
                bigCircleDiameter: bigCircleDiameter,
                backgroundColor: Color(backgroundColor),
                tempo: $tempo
            )
            
            ControlButtonsView(
                tempo: $tempo, startMetronome: startMetronome,
                backgroundColor: backgroundColor,
                bigCircleDiameter: bigCircleDiameter
            )
            
            TempoText(
                tempo: $tempo
            )
        }
    }
}

struct MetronomeViewPrototype_Previews: PreviewProvider {
    static var plug : () -> Void = {  }
    
    static var previews: some View {
        MetronomeViewPrototype(
            tempo: .constant(80),
            bigCircleDiameter: 350,
            startMetronome: plug
        )
    }
}

struct TempoControlDoughnut: View {
    
    let bigCircleDiameter: CGFloat
    let backgroundColor: Color
    
    @Binding var tempo: Double
    
    private var centerHoleDiameter: CGFloat {
        (bigCircleDiameter / 3) * 1.3
    }
    
    var body: some View {
        ZStack {
            ControlCircle(
                bigCircleDiameter: bigCircleDiameter,
                tempo: $tempo
            )
            
            
            Circle()
                .foregroundStyle(
                    backgroundColor.shadow(
                        .inner(color: .white, radius: 0)
                    )
                )
                .frame(width: centerHoleDiameter)
        }
    }
}

struct ControlCircle: View {
    let bigCircleDiameter: CGFloat
    
    @Binding var tempo: Double
    
    @State private var lastAngle: CGFloat = 0
    @State private var counter: CGFloat = 0
    
    var body: some View {
        Circle()
            .foregroundColor(.white)
//            .shadow(color: .white, radius: 3)
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
        }
        .frame(width: 50, height: 50)
        .offset(x: -bigCircleDiameter / 3)
        
        Button(action: tempoPlus) {
            Image(systemName: "plus")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(Color(backgroundColor))
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
