//
//  ControlButtonsView.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 04.07.2023.
//

import SwiftUI

struct ControlButtonsView: View {    
    @StateObject private var viewModel = ControlButtonsViewModel()
    @EnvironmentObject private var dataManager: DataManager
    @EnvironmentObject private var metronome: Metronome

    var body: some View {
        ControlButton(
            buttonAction: viewModel.metronome.buttonWasTapped,
            backgroundColor: viewModel.backgroundColor,
            name: "playpause.fill"
        )
        .offset(y: -viewModel.bigCircleDiameter / 3)
        
        ControlButton(
            buttonAction: viewModel.tempoMinus,
            backgroundColor: viewModel.backgroundColor,
            name: "minus"
        )
        .offset(x: -viewModel.bigCircleDiameter / 3)

        ControlButton(
            buttonAction: viewModel.tempoPlus,
            backgroundColor: viewModel.backgroundColor,
            name: "plus"
        )
        .offset(x: viewModel.bigCircleDiameter / 3)
        
        .onAppear {
            viewModel.dataManager = dataManager
            viewModel.metronome = metronome
        }
    }
}

struct ControlButton: View {
    let buttonAction: () -> Void
    let backgroundColor: UIColor
    let name: String
    
    var body: some View {
        Button(action: buttonAction) {
            Image(systemName: name)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(Color(backgroundColor))
                .frame(width: 70, height: 70)

        }
    }
}
