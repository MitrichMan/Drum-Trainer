//
//  BeatLightsView.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 20.06.2023.
//

import SwiftUI

struct BeatLightsView: View {
    @EnvironmentObject private var metronome: Metronome
    @StateObject private var viewModel = BeatLightsViewModel()
        
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .frame(height: 200)
                .foregroundColor(.white)
            
            VStack {
                ForEach(
                    (1...viewModel.getNumberOfRows(
                        size: metronome.defaultSettings.size
                    )),
                    id: \.self
                ) { rowIndex in
                
                    HStack {
                        ForEach(
                            (1...viewModel.getNumberOfCirclesInRow(
                                size: metronome.defaultSettings.size,
                                rowIndex: rowIndex
                            )),
                            id: \.self
                        ) { index in
                            
                            ZStack {
                                AccentNimbusView(
                                    beatSelection: metronome.defaultSettings.selectedBeats[
                                        viewModel.getIndexForElement(
                                            rowIndex: rowIndex,
                                            index: index,
                                            size: metronome.defaultSettings.size
                                        )
                                    ] ?? .weak,
                                    color: viewModel.playingBeatCircleColorSetUp(
                                        beat: metronome.beat,
                                        index: viewModel.getIndexForElement(
                                            rowIndex: rowIndex,
                                            index: index,
                                            size: metronome.defaultSettings.size
                                        )
                                    )
                                )
                                
                                BeatCircleView(
                                    playingBeatCircleColor: viewModel.playingBeatCircleColorSetUp(
                                        beat: metronome.beat,
                                        index: viewModel.getIndexForElement(
                                            rowIndex: rowIndex,
                                            index: index,
                                            size: metronome.defaultSettings.size
                                        )
                                    ),
                                    circleDiameter: viewModel.setUpCircleAppearance(
                                        index: viewModel.getIndexForElement(
                                            rowIndex: rowIndex,
                                            index: index,
                                            size: metronome.defaultSettings.size
                                        )
                                    )
                                )
                                .padding(10)
                                .onTapGesture {
                                    viewModel.selectBeats(
                                        from: viewModel.getIndexForElement(
                                            rowIndex: rowIndex,
                                            index: index,
                                            size: metronome.defaultSettings.size
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
        }
        
        .onChange(of: metronome.defaultSettings.size) { newValue in
            viewModel.deInitUnusedBeats()
            viewModel.setUpBeatSelection()
        }
    }
}

struct BeatLightsView_Previews: PreviewProvider {
    static var previews: some View {
        BeatLightsView()
        .environmentObject(Metronome())
    }
}
