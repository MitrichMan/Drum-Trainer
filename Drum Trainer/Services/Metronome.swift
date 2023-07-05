//
//  Metronome.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 31.05.2023.
//

import Combine
import UIKit

class Metronome: ObservableObject {
    let objectWillChange = PassthroughSubject<Metronome, Never>()
    
    @Published var beat = 0
    @Published var size: Size = .four {
        didSet {
            objectWillChange.send(self)
        }
    }
    @Published var subdivision: Subdivision = .quarter
    @Published var tempo = 80.0 {
        didSet {
            objectWillChange.send(self)

            if player.player?.isPlaying == true {
                killMetronome()
                startMetronome()
            }
        }
    }
    
    var beatSelection: BeatSelection = .accent
    
    private var timeUnit = 0
    
    private let player = SoundPlayer()
    private var metronome: Timer?
    
    private var isPlaying = false
    private var wasPlayed = false
    
    // MARK: - Interface
    func buttonWasTapped() {
        if !isPlaying {
            isPlaying.toggle()
            startMetronome()
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
        playSound()
        setUpBeats()
        objectWillChange.send(self)
    }
    
    private func startMetronome() {
        metronome = Timer.scheduledTimer(
            timeInterval: setBaseInterval(),
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
    private func setBaseInterval() -> Double {
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
            } else if beat >= size.rawValue {
                beat = 1
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
