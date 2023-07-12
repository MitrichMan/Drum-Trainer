//
//  BeatLightsView.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 20.06.2023.
//

import SwiftUI

struct BeatLightsView: View {
    @StateObject private var viewModel = BeatLightsViewModel()
    
    @EnvironmentObject private var metronome: Metronome
    @EnvironmentObject private var dataManager: DataManager

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .frame(height: 200)
                .foregroundColor(.white)
            
            VStack {
                ForEach(
                    (1...viewModel.numberOfRows), id: \.self) { rowIndex in
                        
                    HStack {
                        ForEach(
                            (1...viewModel.getNumberOfCirclesInRow(rowIndex: rowIndex)),

                            id: \.self
                        ) { index in
                            
                            ZStack {
                                AccentNimbusView(
                                    beatSelection: dataManager.defaultSettings.selectedBeats[
                                        viewModel.getIndexForElement(
                                            rowIndex: rowIndex,
                                            index: index
                                        )
                                    ] ?? .weak,
                                    color: viewModel.playingBeatCircleColorSetUp(
                                        beat: metronome.beat,
                                        index: viewModel.getIndexForElement(
                                            rowIndex: rowIndex,
                                            index: index
                                        ),
                                        selectedBeats: dataManager.defaultSettings.selectedBeats
                                    )
                                )
                                
                                BeatCircleView(
                                    playingBeatCircleColor: viewModel.playingBeatCircleColorSetUp(
                                        beat: metronome.beat,
                                        index: viewModel.getIndexForElement(
                                            rowIndex: rowIndex,
                                            index: index
                                        ),
                                        selectedBeats: dataManager.defaultSettings.selectedBeats
                                    ),
                                    circleDiameter: viewModel.setUpCircleAppearance(
                                        index: viewModel.getIndexForElement(
                                            rowIndex: rowIndex,
                                            index: index
                                        ),
                                        selectedBeats: dataManager.defaultSettings.selectedBeats
                                    )
                                )
                                .padding(10)
                                .onTapGesture {
                                    metronome.selectBeats(
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
            metronome.setUpBeatSelection()
            metronome.deInitUnusedBeats()
            viewModel.getNumberOfRows(size: dataManager.defaultSettings.size)
            viewModel.getNumberOfCirclesInRows(size: dataManager.defaultSettings.size)
        }
        .onChange(of: dataManager.defaultSettings.size) { newValue in
            metronome.setUpBeatSelection()
            metronome.deInitUnusedBeats()
            viewModel.getNumberOfRows(size: dataManager.defaultSettings.size)
            viewModel.getNumberOfCirclesInRows(size: dataManager.defaultSettings.size)
        }
    }
}

struct BeatLightsView_Previews: PreviewProvider {
    static var previews: some View {
        BeatLightsView()
        .environmentObject(Metronome())
        .environmentObject(DataManager())
    }
}
