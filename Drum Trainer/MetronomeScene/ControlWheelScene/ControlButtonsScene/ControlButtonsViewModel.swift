//
//  ControlButtonsViewModel.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 04.07.2023.
//

import UIKit
import Combine

class ControlButtonsViewModel: ObservableObject {
    var dataManager = DataManager()
    var metronome = Metronome()
    
    // must make next in data model
    let backgroundColor = UIColor(named: "BackgroundColor") ?? .systemGray5
    let bigCircleDiameter: CGFloat = 350
    
    let objectWillChange = ObservableObjectPublisher()
    
    func tempoMinus() {
        dataManager.defaultSettings.tempo -= 1
    }
    
    func tempoPlus() {
        dataManager.defaultSettings.tempo += 1
    }
}
