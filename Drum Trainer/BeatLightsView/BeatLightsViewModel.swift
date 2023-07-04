//
//  BeatLightsViewModel.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 04.07.2023.
//

import SwiftUI

class BeatLightsViewModel: ObservableObject {
    
    @Published var size: Size = .four
            
    @Published var selectedBeats: [Int: BeatSelection] = [1: .accent]

    @Published var beat: Int = 0

    @Published var numberOfRows = 1
    @Published var numberOfCirclesInFirstRow = 4
    @Published var numberOfCirclesInSecondRow = 0

    private let metronome: Metronome = Metronome()
    
    // MARK: - Selection
    func setUpBeatSelection() {
         for beat in 2...size.rawValue {
             if selectedBeats[beat] == nil {
                 selectedBeats[beat] = .weak
             }
         }
     }
     
    func deInitUnusedBeats() {
         if selectedBeats.count > size.rawValue {
             selectedBeats[size.rawValue + 1] = nil
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
         numberOfRows = size.rawValue > 4 ? 2 : 1
     }
     
    func getNumberOfCirclesInRow() {
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
         let indexOfElement: Int
         
         if rowIndex == 1 {
             indexOfElement = index
         } else {
             indexOfElement = index + numberOfCirclesInFirstRow
         }
         
         return indexOfElement
     }
}
