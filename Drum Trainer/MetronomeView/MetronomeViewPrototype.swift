//
//  MetronomeViewPrototype.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 01.06.2023.
//

import SwiftUI

struct MetronomeViewPrototype: View {
    
    @State private var tempo = 40
    @State private var rotation: Angle = Angle(degrees: 0)
    
    @State private var currentAngle = Angle.zero
    @GestureState private var twistAngle = Angle.zero
    
    let backgroundColor = UIColor(named: "BackgroundColor") ?? .systemGray5
    
    var body: some View {
        
        ZStack {
            Color(backgroundColor)
                .ignoresSafeArea()
            
            tempoControlDoughnut(
                bigCircleDiameter: 350,
                backgroundColor: Color(backgroundColor),
                tempo: $tempo,
                rotation: $rotation
            )
            
            Text(tempo.formatted())
                .frame(width: 350, height: 350)
                .font(.custom("Arial Rounded MT Bold", size: 70))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
        }
    }
}

struct MetronomeViewPrototype_Previews: PreviewProvider {
    static var previews: some View {
        MetronomeViewPrototype()
    }
}

struct tempoControlDoughnut: View {
    
    let bigCircleDiameter: CGFloat
    let backgroundColor: Color
    
    @Binding var tempo: Int
    @Binding var rotation: Angle
    
    
    private var centerHoleDiameter: CGFloat {
        (bigCircleDiameter / 3) * 1.3
    }
    
    var body: some View {
        ZStack {
            ControlCircle(
                bigCircleDiameter: bigCircleDiameter,
                tempo: $tempo,
                rotation: $rotation
            )
            
            
            Circle()
                .foregroundStyle(
                        backgroundColor.shadow(
                            .inner(color: .white, radius: 3)
                        )
                    )
                .frame(width: centerHoleDiameter)
        }
    }
}

struct ControlCircle: View {
    
    let bigCircleDiameter: CGFloat
    
    @Binding var tempo: Int
    @Binding var rotation: Angle
    @State private var previousRotation: Angle?
    
    @State private var lastAngle: CGFloat = 0
    @State private var counter: CGFloat = 0
    
    var body: some View {
        Circle()
            .foregroundColor(.white)
            .shadow(color: .white, radius: 3)
            .frame(width: bigCircleDiameter)
            .gesture(DragGesture()
                .onChanged{ value in
                    let deltaX = value.location.x - bigCircleDiameter / 2
                    let deltaY = bigCircleDiameter / 2 - value.location.y
                    var angle = atan2(deltaX, deltaY) * 180 / .pi
                    if (angle < 0) { angle += 360 }

                    let theta = self.lastAngle - angle
                    self.lastAngle = angle

                    if (abs(theta) < 20) {
                        self.counter += theta
                    }
                    
                    if self.counter > 20 && tempo > 40 {
                        tempo -= 1
                    } else if self.counter < -20 && tempo < 400{
                        tempo += 1
                    }
                   
                    if (abs(self.counter) > 20) { self.counter = 0 }
                    
                }
                             .onEnded { v in
                                 self.counter = 0
                             })
    }
}
