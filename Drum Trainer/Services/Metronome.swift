//
//  Metronome.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 31.05.2023.
//

import Combine
import Foundation

class Metronome: ObservableObject {
    let objectWillChange = PassthroughSubject<Metronome, Never>()
    
    
    var beat = 0
    var buttonTitle = "Start"
    var size = 4
        
    private var metronome: Timer?
    
    func startMetronome(tempo: Double) {
        
        let interval = 60 / tempo
        
        metronome = Timer.scheduledTimer(
            timeInterval: interval,
            target: self,
            selector: #selector(updateCurrentBeat),
            userInfo: nil,
            repeats: true
        )
        
//        buttonWasTapped()
    }
    
    func buttonWasTapped(tempo: Double) {
        if buttonTitle == "Start" {
            buttonTitle = "Stop"
            beat = 1
            startMetronome(tempo: tempo)
        } else {
            buttonTitle = "Start"
            killMetronome()
            beat = 0
        }
        
        objectWillChange.send(self)
    }
    
    @objc private func updateCurrentBeat() {
        if beat == size {
            beat = 1
        }  else {
            beat += 1
        }
        
        objectWillChange.send(self)
    }
    
    private func killMetronome() {
        metronome?.invalidate()
        metronome = nil
    }
}


