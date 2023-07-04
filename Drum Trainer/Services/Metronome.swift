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
    
    var beatSelection: BeatSelection = .accent
    var beat = 0
    var timeUnit = 0
    var size: Size = .four
    var subdivision: Subdivision = .quarter
    var tempo = 80.0 {
        didSet {
            if player.player?.isPlaying == true {
                killMetronome()
                startMetronome(tempo: tempo, subdivision: subdivision.rawValue)
            }
        }
    }
    
    private let player = SoundPlayer()
    private var metronome: Timer?
    
    private var isPlaying = false
    private var wasPlayed = false
    
    // MARK: - Interface
    func buttonWasTapped(tempo: Double, size: Int, subdivision: Int) {
        if !isPlaying {
            isPlaying.toggle()
            startMetronome(tempo: tempo, subdivision: subdivision)
            metronomeActions()
        } else {
            isPlaying.toggle()
            killMetronome()
            beat = 0
            timeUnit = 0
            wasPlayed = false
        }
        
        objectWillChange.send(self)
    }
    
    // MARK: - Metronome methods
    @objc private func metronomeActions() {
        //        player.playSound()
        playSound()
        setUpBeats()
        objectWillChange.send(self)
    }
    
    private func startMetronome(tempo: Double, subdivision: Int) {
        metronome = Timer.scheduledTimer(
            //            timeInterval: setInterval(tempo: tempo, subdivision: subdivision),
            timeInterval: setBaseInterval(tempo: tempo),
            target: self,
            selector: #selector(metronomeActions),
            userInfo: nil,
            repeats: true
        )
    }
    
    private func killMetronome() {
        metronome?.invalidate()
        metronome = nil
    }
    
    // MARK: - Time
    private func setInterval(tempo: Double, subdivision: Int) -> Double {
        60 / tempo
    }
    
    private func setBaseInterval(tempo: Double) -> Double {
        60 / (tempo * 16)
    }
    
    // MARK: - Beat
    private func setTimeUnit() {
        if timeUnit != 16 {
            timeUnit += 1
        } else {
            timeUnit = 1
        }
    }
    
    private func setUpBeats() {
        setTimeUnit()
        if timeUnit == 1 {
            if beat <= size.rawValue {
                if beat == size.rawValue {
                    beat = 1
                    wasPlayed = false
                } else {
                    beat += 1
                }
            }
        }
    }
    
    private func playSound() {
        if subdivision.rawValue == 2 {
            if timeUnit == 1 {
                if wasPlayed == false {
                    player.playSound(beat: beatSelection)
                    wasPlayed = true
                } else {
                    wasPlayed = false
                }
            }
        } else if subdivision.rawValue == 4 {
            if timeUnit == 1 {
                player.playSound(beat: beatSelection)
            }
        } else if subdivision.rawValue == 8 {
            if timeUnit == 1 {
                player.playSound(beat: beatSelection)
            } else if timeUnit == 9 {
                player.playSound(beat: .weak)
            }
        } else if subdivision.rawValue == 16 {
            if timeUnit == 1 {
                player.playSound(beat: beatSelection)
            } else if timeUnit == 5 || timeUnit == 9 || timeUnit == 13 {
                player.playSound(beat: .weak)
            }
        }
    }
}
