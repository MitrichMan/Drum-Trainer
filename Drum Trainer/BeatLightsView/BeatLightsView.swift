//
//  BeatLightsView.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 20.06.2023.
//

import SwiftUI

struct BeatLightsView: View {
    @Binding var size: Size
    
    @State private var selectedBeats: [Int: BeatSelection] = [1: .accent]
    
    @State private var numberOfRows = 1
    @State private var numberOfCirclesInFirstRow = 4
    @State private var numberOfCirclesInSecondRow = 0
    
    let metronome: Metronome
    
    let beat: Int
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .frame(width: 350, height: 200)
                .foregroundColor(.white)
            
            VStack {
                ForEach((1...numberOfRows), id: \.self) { rowIndex in
                    
                    HStack {
                        ForEach((1...getNumberOfElements(rowIndex: rowIndex)), id: \.self) { index in
                            
                            ZStack {
                                AccentNimbusView(
                                    beatSelection: selectedBeats[
                                        getIndexForElement(
                                            rowIndex: rowIndex,
                                            index: index
                                        )
                                    ] ?? .weak,
                                    color: playingBeatCircleColorSetUp(
                                        beat: beat,
                                        index: getIndexForElement(
                                            rowIndex: rowIndex,
                                            index: index
                                        )
                                    )
                                )
                                
                                BeatCircle(
                                    playingBeatCircleColor: playingBeatCircleColorSetUp(
                                        beat: beat,
                                        index: getIndexForElement(
                                            rowIndex: rowIndex,
                                            index: index
                                        )
                                    ),
                                    circleDiameter: setUpCircleAppearance(
                                        index: getIndexForElement(
                                            rowIndex: rowIndex,
                                            index: index
                                        )
                                    )
                                )
                                .padding(10)
                                .onTapGesture {
                                    selectBeats(
                                        from: getIndexForElement(
                                            rowIndex: rowIndex,
                                            index: index
                                        )
                                    )
                                }
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            setUpBeatSelection()
        }
        .onChange(of: size) { _ in
            getNumberOfRows()
            getNumberOfCirclesInRow()
            deInitUnusedBeats()
            setUpBeatSelection()
        }
    }
    
   // MARK: - Selection
    private func setUpBeatSelection() {
        for beat in 2...size.rawValue {
            if selectedBeats[beat] == nil {
                selectedBeats[beat] = .weak
            }
        }
    }
    
    private func deInitUnusedBeats() {
        if selectedBeats.count > size.rawValue {
            selectedBeats[size.rawValue + 1] = nil
        }
    }
    
    private func selectBeats(from index: Int) {
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
    private func playingBeatCircleColorSetUp(beat: Int, index: Int) -> Color {
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
    
    private func setUpCircleAppearance(index: Int) -> Double {
        let diameterOfCircle = selectedBeats[index] == .ghost ? 16.0 : 40.0
        return diameterOfCircle
    }
    
    // MARK: - Number
    private func getNumberOfRows() {
        numberOfRows = size.rawValue > 4 ? 2 : 1
    }
    
    private func getNumberOfCirclesInRow() {
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
    
    private func getNumberOfElements(rowIndex: Int) -> Int {
        let numberOfElements: Int
        
        if rowIndex == 1 {
            numberOfElements = numberOfCirclesInFirstRow
        } else {
            numberOfElements = numberOfCirclesInSecondRow
        }
        return numberOfElements
    }
    
    private func getIndexForElement(rowIndex: Int, index: Int) -> Int {
        let indexOfElement: Int
        
        if rowIndex == 1 {
            indexOfElement = index
        } else {
            indexOfElement = index + numberOfCirclesInFirstRow
        }
        
        return indexOfElement
    }
}

struct BeatLightsView_Previews: PreviewProvider {
    static var previews: some View {
        BeatLightsView(size: .constant(Size.five), metronome: Metronome(), beat: 3)
    }
}

struct AccentNimbusView: View {
    let beatSelection: BeatSelection
    let color: Color
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(color)
                .frame(width: 52)
            Circle()
                .foregroundColor(.white)
                .frame(width: 46)
        }
        .opacity(setUpOpacity())
    }
    
    private func setUpOpacity() -> Double {
        let opacity: Double
        if beatSelection == .accent {
            opacity = 1.0
        } else {
            opacity = 0.0
        }
        return opacity
    }
}

struct BeatCircle: View {
    let playingBeatCircleColor: Color

    let circleDiameter: Double
    
    var body: some View {
        Circle()
            .frame(width: circleDiameter)
            .foregroundColor(playingBeatCircleColor)
    }
}
