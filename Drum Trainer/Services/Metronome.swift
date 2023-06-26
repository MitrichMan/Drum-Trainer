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
    var subdivision = 4
    var tempo = 80.0 {
        didSet {
            if player?.isPlaying == true {
                killMetronome()
                startMetronome(tempo: tempo, subdivision: subdivision)
            }
        }
    }
    
    private var isPlaying = false
    
    private var metronome: Timer?
    
    
    func buttonWasTapped(tempo: Double, size: Int, subdivision: Int) {
        if !isPlaying {
            isPlaying.toggle()
            startMetronome(tempo: tempo, subdivision: subdivision)
            metronomeActions()
        } else {
            isPlaying.toggle()
            killMetronome()
            beat = 0
        }
        
        objectWillChange.send(self)
    }
    
    @objc private func metronomeActions() {
        playSound()
        setUpBeats()
        objectWillChange.send(self)
    }
    
    private func startMetronome(tempo: Double, subdivision: Int) {
        metronome = Timer.scheduledTimer(
            timeInterval: setInterval(tempo: tempo, subdivision: subdivision),
            target: self,
            selector: #selector(metronomeActions),
            userInfo: nil,
            repeats: true
        )
    }
    
    private func setInterval(tempo: Double, subdivision: Int) -> Double {
        60 / tempo * 4 / Double(subdivision)
    }
    
    private func setUpBeats() {
        if beat <= size {
            if beat == size {
                beat = 1
            }  else {
                beat += 1
            }
        }
    }
    
    private func playSound() {
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
    
    private func killMetronome() {
        metronome?.invalidate()
        metronome = nil
    }
}
