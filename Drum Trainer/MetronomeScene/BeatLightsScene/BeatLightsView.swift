//
//  BeatLightsView.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 20.06.2023.
//

import SwiftUI

struct BeatLightsView: View {
    @EnvironmentObject private var metronome: Metronome
    @EnvironmentObject private var dataManager: DataManager

    @StateObject private var viewModel = BeatLightsViewModel()
        
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .frame(width: 350, height: 200)
                .foregroundColor(.white)
            
            VStack {
                ForEach(
                    (1...viewModel.getNumberOfRows(
                        size: dataManager.defaultSettings.size.rawValue
                    )),
                    id: \.self
                ) { rowIndex in
                    
                    HStack {
                        ForEach(
                            (1...viewModel.getNumberOfCirclesInRow(
                                size: dataManager.defaultSettings.size.rawValue,
                                rowIndex: rowIndex
                            )),
                            id: \.self
                        ) { index in
                            
                            ZStack {
                                AccentNimbusView(
                                    beatSelection: dataManager.defaultSettings.selectedBeats[
                                        viewModel.getIndexForElement(
                                            rowIndex: rowIndex,
                                            index: index,
                                            size: dataManager.defaultSettings.size.rawValue
                                        )
                                    ] ?? .weak,
                                    color: viewModel.playingBeatCircleColorSetUp(
                                        beat: metronome.beat,
                                        index: viewModel.getIndexForElement(
                                            rowIndex: rowIndex,
                                            index: index,
                                            size: dataManager.defaultSettings.size.rawValue
                                        )
                                    )
                                )
                                
                                BeatCircleView(
                                    playingBeatCircleColor: viewModel.playingBeatCircleColorSetUp(
                                        beat: metronome.beat,
                                        index: viewModel.getIndexForElement(
                                            rowIndex: rowIndex,
                                            index: index,
                                            size: dataManager.defaultSettings.size.rawValue
                                        )
                                    ),
                                    circleDiameter: viewModel.setUpCircleAppearance(
                                        index: viewModel.getIndexForElement(
                                            rowIndex: rowIndex,
                                            index: index,
                                            size: dataManager.defaultSettings.size.rawValue
                                        )
                                    )
                                )
                                .padding(10)
                                .onTapGesture {
                                    viewModel.selectBeats(
                                        from: viewModel.getIndexForElement(
                                            rowIndex: rowIndex,
                                            index: index,
                                            size: dataManager.defaultSettings.size.rawValue
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
            viewModel.dataManager = dataManager
            viewModel.setUpBeatSelection()
        }
        
        .onChange(of: dataManager.defaultSettings.size) { _ in
            viewModel.deInitUnusedBeats()
            viewModel.setUpBeatSelection()
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
