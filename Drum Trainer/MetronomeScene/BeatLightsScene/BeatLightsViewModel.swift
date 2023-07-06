//
//  BeatLightsViewModel.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 04.07.2023.
//

import SwiftUI

class BeatLightsViewModel: ObservableObject {
    
    @ObservedObject var metronome = Metronome()
    @ObservedObject var dataManager = DataManager()
    
    // MARK: - Selection
    func setUpBeatSelection() {
        for beat in 2...metronome.size.rawValue {
            if metronome.selectedBeats[beat] == nil {
                metronome.selectedBeats[beat] = .weak
            }
        }
    }
    
    func deInitUnusedBeats() {
        if metronome.selectedBeats.count > metronome.size.rawValue {
            for beat in (metronome.size.rawValue + 1)...metronome.selectedBeats.count {
                metronome.selectedBeats[beat] = nil
            }
        }
    }
    
    func selectBeats(from index: Int) {
        switch metronome.selectedBeats[index] {
        case .accent:
            metronome.selectedBeats[index] = .ghost
        case .weak:
            metronome.selectedBeats[index] = .accent
        default:
            metronome.selectedBeats[index] = .weak
        }
    }
    
    // MARK: - Appearance
    func playingBeatCircleColorSetUp(beat: Int, index: Int) -> Color {
        let color: Color
        
        if beat == index {
            switch metronome.selectedBeats[index] {
            case .accent:
                color = .green
                metronome.beatSelection = .accent
            case .weak:
                color = .red
                metronome.beatSelection = .weak
            default:
                color = .yellow
                metronome.beatSelection = .ghost
            }
        } else {
            color = Color("BackgroundColor")
        }
        
        return color
    }
    
    func setUpCircleAppearance(index: Int) -> Double {
        let diameterOfCircle = metronome.selectedBeats[index] == .ghost ? 16.0 : 40.0
        return diameterOfCircle
    }
    
    // MARK: - Number
    func getNumberOfRows(size: Int) -> Int {
        size > 4 ? 2 : 1
    }
    
    func getNumberOfCirclesInRow(size: Int, rowIndex: Int) -> Int {
        if size > 4 {
            if size % 2 == 0 {
                return size / 2
            } else {
                return rowIndex == 1 ?  (size - 1) / 2 + 1 : (size - 1) / 2
            }
        }
        return size
    }
    
    func getIndexForElement(rowIndex: Int, index: Int, size: Int) -> Int {
        rowIndex == 1 ? index : index + getNumberOfCirclesInRow(size: size, rowIndex: 1)
    }
}
