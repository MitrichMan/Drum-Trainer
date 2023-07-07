//
//  BeatLightsViewModel.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 04.07.2023.
//

import SwiftUI
import Combine

class BeatLightsViewModel: ObservableObject {
    @ObservedObject var metronome = Metronome()
        
    // MARK: - Selection
    func setUpBeatSelection() {
        for beat in 2...metronome.defaultSettings.size.rawValue {
            if metronome.defaultSettings.selectedBeats[beat] == nil {
                metronome.defaultSettings.selectedBeats[beat] = .weak
            }
        }
    }
    
    func deInitUnusedBeats() {
        if metronome.defaultSettings.selectedBeats.count > metronome.defaultSettings.size.rawValue {
            for beat in (metronome.defaultSettings.size.rawValue + 1)...metronome.defaultSettings.selectedBeats.count {
                metronome.defaultSettings.selectedBeats[beat] = nil
            }
        }
    }
    
    func selectBeats(from index: Int) {
        switch metronome.defaultSettings.selectedBeats[index] {
        case .accent:
            metronome.defaultSettings.selectedBeats[index] = .ghost
        case .weak:
            metronome.defaultSettings.selectedBeats[index] = .accent
        default:
            metronome.defaultSettings.selectedBeats[index] = .weak
        }
    }
    
    // MARK: - Appearance
    func playingBeatCircleColorSetUp(beat: Int, index: Int) -> Color {
        let color: Color
        
        if beat == index {
            switch metronome.defaultSettings.selectedBeats[index] {
            case .accent:
                color = .green
                metronome.defaultSettings.beatSelection = .accent
            case .weak:
                color = .red
                metronome.defaultSettings.beatSelection = .weak
            default:
                color = .yellow
                metronome.defaultSettings.beatSelection = .ghost
            }
        } else {
            color = Color("BackgroundColor")
        }
        
        return color
    }
    
    func setUpCircleAppearance(index: Int) -> Double {
        let diameterOfCircle = metronome.defaultSettings.selectedBeats[index] == .ghost ? 16.0 : 40.0
        return diameterOfCircle
    }
    
    // MARK: - Number
    func getNumberOfRows(size: Size) -> Int {
        size.rawValue > 4 ? 2 : 1
    }
    
    func getNumberOfCirclesInRow(size: Size, rowIndex: Int) -> Int {
        if size.rawValue > 4 {
            if size.rawValue % 2 == 0 {
                return size.rawValue / 2
            } else {
                return rowIndex == 1 ?  (size.rawValue - 1) / 2 + 1 : (size.rawValue - 1) / 2
            }
        }
        return size.rawValue
    }
    
    func getIndexForElement(rowIndex: Int, index: Int, size: Size) -> Int {
        rowIndex == 1 ? index : index + getNumberOfCirclesInRow(size: size, rowIndex: 1)
    }
}
