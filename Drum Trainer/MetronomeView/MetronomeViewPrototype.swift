//
//  MetronomeViewPrototype.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 01.06.2023.
//

import SwiftUI

struct MetronomeViewPrototype: View {
    
    @State private var tempo = "40"
    @State private var rotation: Angle = Angle(degrees: 0)
    
    @State private var currentAngle = Angle.zero
    @GestureState private var twistAngle = Angle.zero
    
    var body: some View {
        
        ZStack {
#warning("Get rid of force unwrapping")
            Color(UIColor(named: "BackgroundColor")!)
                .ignoresSafeArea()
            
            tempoControlDoughnut(
                bigCircleDiameter: 350,
                tempo: $tempo,
                rotation: $rotation
            )
            
            Text(tempo)
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
    
    @Binding var tempo: String
    @Binding var rotation: Angle
    
    private var centerHoleDiameter: CGFloat {
        (bigCircleDiameter / 3) * 1.5
    }
    
    var body: some View {
        ZStack {
            ControlCircle(
                bigCircleDiameter: bigCircleDiameter,
                tempo: $tempo,
                rotation: $rotation
            )
            
            
            Circle()
                .foregroundColor(Color(UIColor(named: "BackgroundColor")!))
                .blur(radius: 1.5)
                .frame(width: centerHoleDiameter)
            
        }
    }
}

struct ControlCircle: View {
    
    let bigCircleDiameter: CGFloat
    
    @Binding var tempo: String
    @Binding var rotation: Angle
    @State private var previousRotation: Angle?
    
    var body: some View {
        Circle()
            .foregroundColor(.white)
            .shadow(color: .white, radius: 5)
            .frame(width: bigCircleDiameter)
            .rotationEffect(rotation, anchor: .center)
            .gesture(DragGesture()
                .onChanged{ value in
                    if let previousRotation = self.previousRotation {
                        let deltaY = value.location.y - (bigCircleDiameter / 2)
                        let deltaX = value.location.x - (bigCircleDiameter / 2)
                        let fingerAngle = Angle(radians: Double(atan2(deltaY, deltaX)))
                        
                        let angle = fingerAngle - previousRotation
                        rotation += angle
#warning("Make tempo counting method")
                        tempo = lround(rotation.degrees).formatted()
                        self.previousRotation = fingerAngle
                        
                    } else {
                        let deltaY = value.location.y - (bigCircleDiameter / 2)
                        let deltaX = value.location.x - (bigCircleDiameter / 2)
                        let fingerAngle = Angle(radians: Double(atan2(deltaY, deltaX)))
                        previousRotation = fingerAngle
                    }
                }
                .onEnded{ _ in
                    previousRotation = nil
                })
    }
}
