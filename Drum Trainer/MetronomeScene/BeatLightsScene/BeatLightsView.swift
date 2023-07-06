//
//  BeatLightsView.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 20.06.2023.
//

import SwiftUI

struct BeatLightsView: View {
    @EnvironmentObject private var metronome: Metronome
    @EnvironmentObject private var settingsModel: DataManager

    @StateObject private var viewModel = BeatLightsViewModel()
        
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .frame(width: 350, height: 200)
                .foregroundColor(.white)
            
            VStack {
                ForEach(
                    (1...viewModel.getNumberOfRows(size: metronome.size.rawValue)),
                    id: \.self
                ) { rowIndex in
                    
                    HStack {
                        ForEach(
                            (1...viewModel.getNumberOfCirclesInRow(
                                size: metronome.size.rawValue,
                                rowIndex: rowIndex
                            )),
                            id: \.self
                        ) { index in
                            
                            ZStack {
                                AccentNimbusView(
                                    beatSelection: metronome.selectedBeats[
                                        viewModel.getIndexForElement(
                                            rowIndex: rowIndex,
                                            index: index,
                                            size: metronome.size.rawValue
                                        )
                                    ] ?? .weak,
                                    color: viewModel.playingBeatCircleColorSetUp(
                                        beat: metronome.beat,
                                        index: viewModel.getIndexForElement(
                                            rowIndex: rowIndex,
                                            index: index,
                                            size: metronome.size.rawValue
                                        )
                                    )
                                )
                                
                                BeatCircleView(
                                    playingBeatCircleColor: viewModel.playingBeatCircleColorSetUp(
                                        beat: metronome.beat,
                                        index: viewModel.getIndexForElement(
                                            rowIndex: rowIndex,
                                            index: index,
                                            size: metronome.size.rawValue
                                        )
                                    ),
                                    circleDiameter: viewModel.setUpCircleAppearance(
                                        index: viewModel.getIndexForElement(
                                            rowIndex: rowIndex,
                                            index: index,
                                            size: metronome.size.rawValue
                                        )
                                    )
                                )
                                .padding(10)
                                .onTapGesture {
                                    viewModel.selectBeats(
                                        from: viewModel.getIndexForElement(
                                            rowIndex: rowIndex,
                                            index: index,
                                            size: metronome.size.rawValue
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
        
        .onChange(of: metronome.size) { _ in
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
