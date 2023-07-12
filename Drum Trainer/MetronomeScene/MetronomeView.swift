//
//  MetronomeView.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 31.05.2023.
//

import SwiftUI

struct MetronomeView: View {
    @StateObject private var viewModel = MetronomeViewModel()
    @EnvironmentObject private var metronome: Metronome
    @EnvironmentObject private var dataManager: DataManager
    
    var body: some View {
        ZStack{
            Color(viewModel.backgroundColor)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                ZStack {
                    RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                        .foregroundColor(.white)
                    VStack(spacing: 0) {
                        BeatLightsView()
                        Divider()
                        
                        HStack(spacing: 0) {
                            SizePickerView()
                            
                            Divider()
                                .frame(height: 100)
                            
                            RhythmPicker()
                            
                            Divider()
                                .frame(height: 100)
                            
                            // Mock
                            RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                                .foregroundColor(.white)
                                .frame(width: 85, height: 50)
                            Divider()
                                .frame(height: 100)
                            RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                                .foregroundColor(.white)
                                .frame(width: 85, height: 50)
                        }
                    }
                }
                
                Spacer()
                
                HStack {
                    Text(metronome.beat.formatted())
                        .font(.largeTitle)
                    
                    Text(dataManager.defaultSettings.beat.formatted())
                    
                    Button("start") {
                        dataManager.defaultSettings.beat += 1
                        print(dataManager.defaultSettings.beat.formatted())
                    }
                }
                
                Spacer()
                
                ControlWheelView(
                    tempo: $dataManager.defaultSettings.tempo,
                    bigCircleDiameter: viewModel.bigCircleDiameter,
                    startMetronome: metronome.buttonWasTapped
                )
                
                Spacer(minLength: 30)
            }
            .padding(.top, 20)
            .padding(.leading, 20)
            .padding(.trailing, 20)
        }
    }
}

struct MetronomeView_Previews: PreviewProvider {
    static var previews: some View {
        MetronomeView()
            .environmentObject(Metronome())
            .environmentObject(DataManager.shared)

    }
}

//    Subdivision picker for now
struct RhythmPicker: View {
    @EnvironmentObject private var metronome: Metronome
    
    @State var dataManager = DataManager.shared
    
    // Change it when work with rhythmic patterns will be done!!!!
    var body: some View {
        Picker("Subdivision", selection: $dataManager.defaultSettings.subdivision) {
            
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
        .frame(width: 85, height: 90)
        .background(.white)
        .cornerRadius(20)
    }
}

struct SizePickerView: View {
    @EnvironmentObject private var metronome: Metronome
    
    @State var dataManager = DataManager.shared
    
    var body: some View {
        Picker("Beat", selection: $dataManager.defaultSettings.size) {
            ForEach(Size.allCases) { size in
                Text(String(describing: size.rawValue))
            }
        }
        .pickerStyle(.wheel)
        .frame(width: 85, height: 90)
        .background(.white)
        .cornerRadius(20)
    }
}

