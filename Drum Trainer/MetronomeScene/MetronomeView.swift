//
//  MetronomeView.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 31.05.2023.
//

import SwiftUI

struct MetronomeView: View {
    @EnvironmentObject private var metronome: Metronome
    @EnvironmentObject private var settingsModel: DataManager
    @StateObject private var viewModel = MetronomeViewModel()
        
    var body: some View {
        ZStack{
            Color(viewModel.backgroundColor)
                .ignoresSafeArea()
            
            VStack {
                Spacer(minLength: 20)
                
                BeatLightsView()
                .padding(.bottom)

                HStack {
                    
                    VStack(spacing: 1) {
                        SizePickerView(
                            size: $metronome.size
                        )

                        
                        RhythmPicker(
                            subdivision: $metronome.subdivision
                        )

                    }
                    .padding(.leading, 20)
                    
                    Spacer()
                    
                    Text(metronome.beat.formatted())
                        .font(.largeTitle)
                                        
                    Spacer(minLength: 185)
                    
                }
                
                ControlWheelView(
                    tempo: $metronome.tempo,
                    bigCircleDiameter: viewModel.bigCircleDiameter,
                    startMetronome: metronome.buttonWasTapped
                )
                
                Spacer(minLength: 50)
            }
        }
        .onAppear {
            viewModel.metronome = metronome
            metronome.settings = settingsModel.settings
        }
    }
}

struct MetronomeView_Previews: PreviewProvider {
    static var previews: some View {
        MetronomeView()
            .environmentObject(Metronome())
            .environmentObject(DataManager())
    }
}

//    Subdivision picker for now
struct RhythmPicker: View {
    @EnvironmentObject private var metronome: Metronome
    @EnvironmentObject private var settingsModel: DataManager


    @Binding var subdivision: Subdivision
        
// Change it when work with rhythmic patterns will be done!!!!
    var body: some View {
        Picker("Subdivision", selection: $subdivision) {
            Image("HalfNote")
                .resizable()
                .foregroundColor(.red)
                .frame(width: 25, height: 25)
                .tag(Subdivision.half)
            Image("QuarterNote")
                .resizable()
                .foregroundColor(.red)
                .frame(width: 25, height: 25)
                .tag(Subdivision.quarter)
            Image("EighthNote")
                .resizable()
                .foregroundColor(.red)
                .frame(width: 25, height: 25)
                .tag(Subdivision.eighth)
            Image("SixteenthNote")
                .resizable()
                .foregroundColor(.red)
                .frame(width: 33, height: 25)
                .tag(Subdivision.sixteenth)
        }
        .pickerStyle(.wheel)
        .frame(width: 100, height: 50)
        .background(.white)
        .cornerRadius(20)
        .onChange(of: subdivision) { _ in
            metronome.subdivision = subdivision
        }
    }
}

struct SizePickerView: View {
    @EnvironmentObject private var metronome: Metronome
    @EnvironmentObject private var settingsModel: DataManager

    @Binding var size: Size
    
    var body: some View {
        Picker("Beat", selection: $size) {
            ForEach(Size.allCases) { size in
                Text(String(describing: size.rawValue)).tag(size)
            }
        }
        .pickerStyle(.wheel)
        .frame(width: 100, height: 50)
        .background(.white)
        .cornerRadius(20)
        .onChange(of: size) { _ in
            metronome.size = size
        }
    }

}

