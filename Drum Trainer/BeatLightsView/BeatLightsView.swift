//
//  BeatLightsView.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 20.06.2023.
//

import SwiftUI

struct BeatLightsView: View {
    @Binding var size: Size {
        didSet {
            getNumberOfRows()
            getNumberOfCirclesInRow()
        }
    }
        
    @State private var selectedBeats: [Int: BeatSelection] = [1: .accent]
    
    @State var numberOfRows = 1
    @State var numberOfCirclesInFirstRow = 4
    @State var numberOfCirclesInSecondRow = 0
    
    let beat: Int
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 350, height: 200)
                .foregroundColor(.white)
                .cornerRadius(30)
            VStack {
                
                ForEach((1...numberOfRows), id: \.self) { rowIndex in
                    HStack {
                        
                        ForEach((1...getNumberOfElements(rowIndex: rowIndex)), id: \.self) { index in
                            ZStack {
                                
                                AccentNimbusView(
                                    beatSelection: selectedBeats[
                                        getIndexForRow(
                                        rowIndex: rowIndex,
                                        index: index
                                    )
                                    ] ?? .weak
                                )
                                
                                Circle()
                                    .tag(getIndexForRow(
                                        rowIndex: rowIndex,
                                        index: index
                                    ))
                                    .frame(width: setUpCircleAppearance(
                                        index: getIndexForRow(
                                            rowIndex: rowIndex,
                                            index: index
                                        )
                                    ))
                                    .foregroundColor(playingBeatCircleColorSetUp(
                                        beat: beat,
                                        index: getIndexForRow(
                                            rowIndex: rowIndex,
                                            index: index
                                        )
                                    ))
                                    .padding(10)
                                    .onTapGesture {
                                        selectBeats(from: getIndexForRow(
                                            rowIndex: rowIndex,
                                            index: index
                                        ))
                                    }
                                    .onAppear {
                                        setUpBeatSelection()
                                    }
                            }
                        }
                    }
                }
            }
        }
        .onChange(of: size) { newValue in
            getNumberOfRows()
            getNumberOfCirclesInRow()
        }
    }
    
    private func playingBeatCircleColorSetUp(beat: Int, index: Int) -> Color {
        let color: Color
        
        if beat == index {
            switch selectedBeats[index] {
            case .accent:
                color = .green
            case .weak:
                color = .red
            case .ghost:
                color = .yellow
            default:
                color = Color("BackgroundColor")
            }
        } else {
            color = Color("BackgroundColor")
        }
        
        return color
    }
    
    private func setUpBeatSelection() {
        for beat in 2...size.rawValue {
            selectedBeats[beat] = .weak
        }
    }
    
    private func setUpCircleAppearance(index: Int) -> Double {
        let circleDiameter: Double
        
        switch selectedBeats[index] {
        case .accent:
            circleDiameter = 40
        case .weak:
            circleDiameter = 40
        case .ghost:
            circleDiameter = 16
        default:
            circleDiameter = 40
        }
        
        return circleDiameter
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
    
    private func getNumberOfRows() {
        if size.rawValue > 4 {
            numberOfRows = 2
        } else {
            numberOfRows = 1
        }
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
    
    private func getIndexForRow(rowIndex: Int, index: Int) -> Int {
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
        BeatLightsView(size: .constant(Size.five), beat: 3)
    }
}

struct AccentNimbusView: View {
    let beatSelection: BeatSelection
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(Color("BackgroundColor"))
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
