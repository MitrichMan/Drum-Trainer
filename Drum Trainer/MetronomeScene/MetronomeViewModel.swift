//
//  MetronomeViewModel.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 01.06.2023.
//

import SwiftUI

class MetronomeViewModel: ObservableObject {
    
    var metronome = Metronome()
    
    let backgroundColor = UIColor(named: "BackgroundColor") ?? .systemGray5
    let bigCircleDiameter: CGFloat = 350
  
    func startButtonWasTapped() {
        metronome.buttonWasTapped()
    }
}
