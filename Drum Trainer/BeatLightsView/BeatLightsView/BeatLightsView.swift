//
//  BeatLightsView.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 20.06.2023.
//

import SwiftUI

struct BeatLightsView: View {
    @EnvironmentObject private var metronome: Metronome
    
    @StateObject var viewModel: BeatLightsViewModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .frame(width: 350, height: 200)
                .foregroundColor(.white)
            
            VStack {
                ForEach((1...viewModel.numberOfRows), id: \.self) { rowIndex in
                    
                    HStack {
                        ForEach((1...viewModel.getNumberOfElements(rowIndex: rowIndex)), id: \.self) { index in
                            
                            ZStack {
                                AccentNimbusView(
                                    beatSelection: viewModel.selectedBeats[
                                        viewModel.getIndexForElement(
                                            rowIndex: rowIndex,
                                            index: index
                                        )
                                    ] ?? .weak,
                                    color: viewModel.playingBeatCircleColorSetUp(
                                        beat: viewModel.beat,
                                        index: viewModel.getIndexForElement(
                                            rowIndex: rowIndex,
                                            index: index
                                        )
                                    )
                                )
                                
                                BeatCircleView(
                                    playingBeatCircleColor: viewModel.playingBeatCircleColorSetUp(
                                        beat: viewModel.beat,
                                        index: viewModel.getIndexForElement(
                                            rowIndex: rowIndex,
                                            index: index
                                        )
                                    ),
                                    circleDiameter: viewModel.setUpCircleAppearance(
                                        index: viewModel.getIndexForElement(
                                            rowIndex: rowIndex,
                                            index: index
                                        )
                                    )
                                )
                                .padding(10)
                                .onTapGesture {
                                    viewModel.selectBeats(
                                        from: viewModel.getIndexForElement(
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
            viewModel.metronome = metronome
            viewModel.setUpBeatSelection()
            viewModel.getNumberOfRows()
            viewModel.getNumberOfCirclesInRow()
            viewModel.deInitUnusedBeats()
            viewModel.setUpBeatSelection()
        }
//        .onChange(of: size) { _ in
//        }
    }
    
//   // MARK: - Selection
//    private func setUpBeatSelection() {
//        for beat in 2...size.rawValue {
//            if selectedBeats[beat] == nil {
//                selectedBeats[beat] = .weak
//            }
//        }
//    }
//
//    private func deInitUnusedBeats() {
//        if selectedBeats.count > size.rawValue {
//            selectedBeats[size.rawValue + 1] = nil
//        }
//    }
//
//    private func selectBeats(from index: Int) {
//        switch selectedBeats[index] {
//        case .accent:
//            selectedBeats[index] = .ghost
//        case .weak:
//            selectedBeats[index] = .accent
//        default:
//            selectedBeats[index] = .weak
//        }
//    }
//
//    // MARK: - Appearance
//    private func playingBeatCircleColorSetUp(beat: Int, index: Int) -> Color {
//        let color: Color
//
//        if beat == index {
//            switch selectedBeats[index] {
//            case .accent:
//                color = .green
//                metronome.beatSelection = .accent
//            case .weak:
//                color = .red
//                metronome.beatSelection = .weak
//            default:
//                color = .yellow
//                metronome.beatSelection = .ghost
//            }
//        } else {
//            color = Color("BackgroundColor")
//        }
//
//        return color
//    }
//
//    private func setUpCircleAppearance(index: Int) -> Double {
//        let diameterOfCircle = selectedBeats[index] == .ghost ? 16.0 : 40.0
//        return diameterOfCircle
//    }
//
//    // MARK: - Number
//    private func getNumberOfRows() {
//        numberOfRows = size.rawValue > 4 ? 2 : 1
//    }
//
//    private func getNumberOfCirclesInRow() {
//        if size.rawValue > 4 {
//            if size.rawValue % 2 == 0 {
//                numberOfCirclesInFirstRow = size.rawValue / 2
//                numberOfCirclesInSecondRow = size.rawValue / 2
//            } else {
//                numberOfCirclesInFirstRow = (size.rawValue - 1) / 2 + 1
//                numberOfCirclesInSecondRow = (size.rawValue - 1) / 2
//            }
//        } else {
//            numberOfCirclesInFirstRow = size.rawValue
//        }
//    }
//
//    private func getNumberOfElements(rowIndex: Int) -> Int {
//        let numberOfElements: Int
//
//        if rowIndex == 1 {
//            numberOfElements = numberOfCirclesInFirstRow
//        } else {
//            numberOfElements = numberOfCirclesInSecondRow
//        }
//        return numberOfElements
//    }
//
//    private func getIndexForElement(rowIndex: Int, index: Int) -> Int {
//        let indexOfElement: Int
//
//        if rowIndex == 1 {
//            indexOfElement = index
//        } else {
//            indexOfElement = index + numberOfCirclesInFirstRow
//        }
//
//        return indexOfElement
//    }
}

struct BeatLightsView_Previews: PreviewProvider {
    static var previews: some View {
        BeatLightsView(
            viewModel: BeatLightsViewModel(
//                metronome: Metronome(),
                beat: 3,
                size: .four
            )
        )
    }
}
