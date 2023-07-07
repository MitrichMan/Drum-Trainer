//
//  BeatLightsViewModel.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 04.07.2023.
//

import SwiftUI

class BeatLightsViewModel: ObservableObject {
//    @EnvironmentObject private var metronome: Metronome
//    @EnvironmentObject private var dataManager: DataManager
    
    @ObservedObject var metronome = Metronome()
    @ObservedObject var dataManager = DataManager()
    
    // MARK: - Selection
    func setUpBeatSelection() {
        for beat in 2...dataManager.defaultSettings.size.rawValue {
            if dataManager.defaultSettings.selectedBeats[beat] == nil {
                dataManager.defaultSettings.selectedBeats[beat] = .weak
            }
        }
    }
    
    func deInitUnusedBeats() {
        if dataManager.defaultSettings.selectedBeats.count > dataManager.defaultSettings.size.rawValue {
            for beat in (dataManager.defaultSettings.size.rawValue + 1)...dataManager.defaultSettings.selectedBeats.count {
                dataManager.defaultSettings.selectedBeats[beat] = nil
            }
        }
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
    }
    
    // MARK: - Appearance
    func playingBeatCircleColorSetUp(beat: Int, index: Int) -> Color {
        let color: Color
        
        if beat == index {
            switch dataManager.defaultSettings.selectedBeats[index] {
            case .accent:
                color = .green
                dataManager.defaultSettings.beatSelection = .accent
            case .weak:
                color = .red
                dataManager.defaultSettings.beatSelection = .weak
            default:
                color = .yellow
                dataManager.defaultSettings.beatSelection = .ghost
            }
        } else {
            color = Color("BackgroundColor")
        }
        
        return color
    }
    
    func setUpCircleAppearance(index: Int) -> Double {
        let diameterOfCircle = dataManager.defaultSettings.selectedBeats[index] == .ghost ? 16.0 : 40.0
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
