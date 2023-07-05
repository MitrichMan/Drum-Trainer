//
//  BeatLightsViewModel.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 04.07.2023.
//

import SwiftUI

class BeatLightsViewModel: ObservableObject {
    
    @Published var selectedBeats: [Int: BeatSelection] = [1: .accent]
    
    @Published var numberOfRows = 1
    @Published var numberOfCirclesInFirstRow = 4
    @Published var numberOfCirclesInSecondRow = 0
    
    @Published var metronome = Metronome()
    
    // MARK: - Selection
    func setUpBeatSelection() {
        for beat in 2...metronome.size.rawValue {
            if selectedBeats[beat] == nil {
                selectedBeats[beat] = .weak
            }
        }
    }
    
    func deInitUnusedBeats() {
        if selectedBeats.count > metronome.size.rawValue {
            for beat in (metronome.size.rawValue + 1)...selectedBeats.count {
                selectedBeats[beat] = nil
            }
        }
    }
    
    func selectBeats(from index: Int) {
        switch selectedBeats[index] {
        case .accent:
            selectedBeats[index] = .ghost
        case .weak:
            selectedBeats[index] = .accent
        default:
            selectedBeats[index] = .weak
        }
    }
    
    // MARK: - Appearance
    func playingBeatCircleColorSetUp(beat: Int, index: Int) -> Color {
        let color: Color
        
        if beat == index {
            switch selectedBeats[index] {
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
        let diameterOfCircle = selectedBeats[index] == .ghost ? 16.0 : 40.0
        return diameterOfCircle
    }
    
    // MARK: - Number
    func getNumberOfRows() {
        numberOfRows = metronome.size.rawValue > 4 ? 2 : 1
    }

    func getNumberOfCirclesInRow() {
        if metronome.size.rawValue > 4 {
            if metronome.size.rawValue % 2 == 0 {
                numberOfCirclesInFirstRow = metronome.size.rawValue / 2
                numberOfCirclesInSecondRow = metronome.size.rawValue / 2
            } else {
                numberOfCirclesInFirstRow = (metronome.size.rawValue - 1) / 2 + 1
                numberOfCirclesInSecondRow = (metronome.size.rawValue - 1) / 2
            }
        } else {
            numberOfCirclesInFirstRow = metronome.size.rawValue
        }
    }
    
    func getNumberOfElements(rowIndex: Int) -> Int {
        let numberOfElements: Int
        if rowIndex == 1 {
            numberOfElements = numberOfCirclesInFirstRow
        } else {
            numberOfElements = numberOfCirclesInSecondRow
        }
        return numberOfElements
    }
    
    func getIndexForElement(rowIndex: Int, index: Int) -> Int {
        rowIndex == 1 ? index : index + numberOfCirclesInFirstRow
    }
}
