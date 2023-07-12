//
//  Metronome.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 31.05.2023.
//

import Combine
import SwiftUI

class Metronome: ObservableObject {
    var dataManager = DataManager()
        
    let objectWillChange = ObservableObjectPublisher()
    
    var beat = 0
            
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
    
    // MARK: - Beat Selection
    func setUpBeatSelection() {
        for beat in 2...dataManager.defaultSettings.size.rawValue {
            if dataManager.defaultSettings.selectedBeats[beat] == nil {
                dataManager.defaultSettings.selectedBeats[beat] = .weak
            }
        }
        objectWillChange.send()

    }
    
    func deInitUnusedBeats() {
        if dataManager.defaultSettings.selectedBeats.count > dataManager.defaultSettings.size.rawValue {
            for beat in (dataManager.defaultSettings.size.rawValue + 1)...dataManager.defaultSettings.selectedBeats.count {
                dataManager.defaultSettings.selectedBeats[beat] = nil
            }
        }
        objectWillChange.send()
    }
    
    func selectBeats(from index: Int) {
        switch dataManager.defaultSettings.selectedBeats[index] {
        case .accent:
                dataManager.defaultSettings.selectedBeats[index] = .ghost
        case .weak:
                dataManager.defaultSettings.selectedBeats[index] = .accent
        default:
                dataManager.defaultSettings.selectedBeats[index] = .weak
        }
        objectWillChange.send()
    }
    
    // MARK: - Metronome methods
    @objc private func metronomeActions() {
        playSound(
            timeUnit: timeUnit,
            subdivision: dataManager.defaultSettings.subdivision.rawValue,
            beat: beat,
            selectedBeats: dataManager.defaultSettings.selectedBeats
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
        objectWillChange.send()
    }
    
    // MARK: - Play Sound
    private func playSound(timeUnit: Int, subdivision: Int, beat: Int, selectedBeats: [Int: BeatSelection]) {
        let unitsToPlay = divideTimeUnitSequence(subdivision: subdivision)
        let selectedBeat = selectedBeats[beat] ?? .accent
        
        for unit in unitsToPlay where timeUnit == unit {
            let beatToPlay = unit == 1 ? selectedBeat : .weak
            
            if unit != 1 || subdivision != 2 || !wasPlayed {
                player.playSound(beat: beatToPlay)
            }
            
            if unit == 1 && subdivision == 2 {
                wasPlayed.toggle()
            }
        }
    }
}
