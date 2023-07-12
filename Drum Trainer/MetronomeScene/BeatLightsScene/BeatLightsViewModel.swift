//
//  BeatLightsViewModel.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 04.07.2023.
//

import SwiftUI
import Combine

class BeatLightsViewModel: ObservableObject {
    
    var numberOfRows = 1 {
        didSet {
            objectWillChange.send()
        }
    }
    
    var numberOfCirclesInFirstRow = 4 {
        didSet {
            objectWillChange.send()
        }
    }
    
    var numberOfCirclesInSecondRow = 0 {
        didSet {
            objectWillChange.send()
        }
    }
        
    let objectWillChange = ObservableObjectPublisher()
        
    // MARK: - Appearance
    func playingBeatCircleColorSetUp(beat: Int, index: Int, selectedBeats: [Int: BeatSelection]) -> Color {
        let color: Color
        
        if beat == index {
            switch selectedBeats[index] {
            case .accent:
                color = .green
            case .weak:
                color = .red
            default:
                color = .yellow
            }
        } else {
            color = Color("BackgroundColor")
        }
        return color
    }
    
    func setUpCircleAppearance(index: Int, selectedBeats: [Int: BeatSelection]) -> Double {
        selectedBeats[index] == .ghost ? 16.0 : 40.0
    }
    
    // MARK: - Number
    func getNumberOfRows(size: Size) {
        numberOfRows = size.rawValue > 4 ? 2 : 1
        objectWillChange.send()
    }
    
    func getNumberOfCirclesInRows(size: Size) {
        if size.rawValue > 4 {
            if size.rawValue % 2 == 0 {
                numberOfCirclesInFirstRow = size.rawValue / 2
                numberOfCirclesInSecondRow = size.rawValue / 2
            } else {
                numberOfCirclesInFirstRow = (size.rawValue - 1) / 2 + 1
                numberOfCirclesInSecondRow = (size.rawValue - 1) / 2
            }
        } else {
            numberOfCirclesInFirstRow = size.rawValue
        }
        objectWillChange.send()
    }
 
    func getNumberOfCirclesInRow(rowIndex: Int) -> Int {
        rowIndex == 1 ? numberOfCirclesInFirstRow : numberOfCirclesInSecondRow
    }
    
    func getIndexForElement(rowIndex: Int, index: Int) -> Int {
        rowIndex == 1 ? index : index + numberOfCirclesInFirstRow
    }
}
