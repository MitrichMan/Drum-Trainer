//
//  MetronomeView.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 31.05.2023.
//

import SwiftUI

struct MetronomeView: View {
    
    @StateObject var metronome = Metronome()
    
    @State private var tempo: Double = 80
    @State private var size = 4
    
    private var beat = 0
    
    
    var body: some View {
        VStack {
            Text(metronome.beat.formatted())
                .font(.largeTitle)
            
            Stepper(value: $tempo, in: 40...300) {
                Text(tempo.formatted())
            }
            .frame(width: 134.0)
            
            Stepper(value: $size, in: 2...8) {
                Text(size.formatted())
            }
            .frame(width: 134.0)
            
            Button(
                action: { self.metronome.buttonWasTapped(tempo: tempo)
                    metronome.size = size
                }, label: { Text(metronome.buttonTitle) }
            )
        }
    }
}

struct MetronomeView_Previews: PreviewProvider {
    static var previews: some View {
        MetronomeView()
    }
}
