//
//  MetronomeViewModel.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 01.06.2023.
//

import SwiftUI

class MetronomeViewModel: ObservableObject {
//    @StateObject var metronome = Metronome()
//    @EnvironmentObject var metronome: Metronome
    var metronome = Metronome()
    
    @Published var tempo = 80.0
    @Published var size: Size = .four
    @Published var subdivision: Subdivision = .quarter
    
    let backgroundColor = UIColor(named: "BackgroundColor") ?? .systemGray5
    
    let bigCircleDiameter: CGFloat = 350
  
    func startButtonWasTapped() {
        metronome.buttonWasTapped(
            tempo: tempo,
            size: size.rawValue,
            subdivision: subdivision.rawValue
        )
        metronome.size = size
        metronome.subdivision = subdivision
    }
}
