//
//  Metronome.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 31.05.2023.
//

import Combine
import AVFoundation
import UIKit

class Metronome: ObservableObject {
    let objectWillChange = PassthroughSubject<Metronome, Never>()
    
    var player: AVAudioPlayer?
    
    var beat = 0
    var size = 4
    var tempo = 80.0
    
    var buttonTitle = "Start"
    
    private var metronome: Timer?
    
    func startMetronome(tempo: Double) {
        
        let interval = 60 / tempo
        
        metronome = Timer.scheduledTimer(
            timeInterval: interval,
            target: self,
            selector: #selector(metronomeActions),
            userInfo: nil,
            repeats: true
        )
    }
    
    func buttonWasTapped(tempo: Double) {
        if buttonTitle == "Start" {
            buttonTitle = "Stop"
            startMetronome(tempo: tempo)
            metronomeActions()
        } else {
            buttonTitle = "Start"
            killMetronome()
            beat = 0
        }
        
        objectWillChange.send(self)
    }
    
    @objc private func metronomeActions() {
        playSound()
        
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
    func playSound() {
        guard let url = NSDataAsset(name: "MetronomeBeep")?.data else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(data: url)
            guard let player = player else { return }
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
