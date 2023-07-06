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
                .frame(width: 350, height: 200)
                .foregroundColor(.white)
            
            VStack {
                ForEach((1...viewModel.numberOfRows), id: \.self) { rowIndex in

                    
                    HStack {
                        ForEach((1...viewModel.getNumberOfElements(rowIndex: rowIndex)), id: \.self) { index in
                            
                            ZStack {
                                AccentNimbusView(
                                    beatSelection: metronome.selectedBeats[
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
                                        )
                                    )
                                )
                                
                                BeatCircleView(
                                    playingBeatCircleColor: viewModel.playingBeatCircleColorSetUp(
                                        beat: metronome.beat,
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
//            viewModel.getNumberOfRows()
//            viewModel.getNumberOfCirclesInRow()
//            viewModel.deInitUnusedBeats()
            viewModel.setUpBeatSelection()
        }
        
        .onChange(of: metronome.size) { _ in
            viewModel.getNumberOfRows()
            viewModel.getNumberOfCirclesInRow()
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
