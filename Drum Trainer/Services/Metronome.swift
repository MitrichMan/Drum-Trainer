//
//  Metronome.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 31.05.2023.
//

import Combine
import SwiftUI

class Metronome: ObservableObject {
    @ObservedObject var dataManager = DataManager() 
    
    let objectWillChange = ObservableObjectPublisher()
    
    var beat = 0
    
//    var tempo = 80.0 {
//        didSet {
//            objectWillChange.send()
//
//            if player.player?.isPlaying == true {
//                killMetronome()
//                startMetronome()
//            }
//        }
//    }
            
    private var timeUnit = 0
    
    private let player = SoundPlayer()
    private var metronome: Timer?
    
    private var isPlaying = false
    private var wasPlayed =  false
    
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
        
        objectWillChange.send()
    }
    
    // MARK: - Metronome methods
    @objc private func metronomeActions() {
        playSound(
            limeUnit: timeUnit,
            subdivision: dataManager.defaultSettings.subdivision.rawValue,
            beatSelection: dataManager.defaultSettings.beatSelection
        )
        setUpBeats(size: dataManager.defaultSettings.size.rawValue)
        objectWillChange.send()
    }
    
    private func startMetronome() {
        metronome = Timer.scheduledTimer(
            timeInterval: setBaseInterval(tempo: dataManager.defaultSettings.tempo),
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
    
    private func setUpBeats(size: Int) {
        setTimeUnit()
        if timeUnit == 1 {
            if beat <= size {
                if beat == size {
                    beat = 1
                    wasPlayed = false
                } else {
                    beat += 1
                }
            } else if beat >= size {
                beat = 1
            }
        }
    }
    
    // MARK: - Play Sound
    private func playSound(limeUnit: Int, subdivision: Int, beatSelection: BeatSelection) {
        let unitsToPlay = divideTimeUnitSequence(subdivision: subdivision)
        
        for unit in unitsToPlay where timeUnit == unit {
            let beat = unit == 1 ? beatSelection : .weak
            
            if unit != 1 || subdivision != 2 || !wasPlayed {
                player.playSound(beat: beat)
            }
            
            if unit == 1 && subdivision == 2 {
                wasPlayed.toggle()
            }
        }
    }
    
    private func divideTimeUnitSequence(subdivision: Int) -> [Int] {
        guard subdivision != 2 else { return [1] }
        
        var beatsToPlay: [Int] = []
        var timeUnit = 1
        
        while timeUnit < 16 {
            beatsToPlay.append(timeUnit)
            timeUnit += 16 / (subdivision / 4)
        }
        return beatsToPlay
    }
}
