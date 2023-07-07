//
//  MetronomeView.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 31.05.2023.
//

import SwiftUI

struct MetronomeView: View {
    @EnvironmentObject private var metronome: Metronome
    @StateObject private var viewModel = MetronomeViewModel()
    
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
                    
                    Text(metronome.defaultSettings.beat.formatted())
                    
                    Button("start") {
                        metronome.defaultSettings.beat += 1
                        print(metronome.defaultSettings.beat.formatted())
                    }
                }
                
                Spacer()
                
                ControlWheelView(
                    tempo: $metronome.defaultSettings.tempo,
                    bigCircleDiameter: viewModel.bigCircleDiameter,
                    startMetronome: metronome.buttonWasTapped
                )
                
                Spacer(minLength: 30)
            }
            .padding(.top, 20)
            .padding(.leading, 20)
            .padding(.trailing, 20)
        }
        .onAppear {
            viewModel.metronome = metronome
        }
    }
}

struct MetronomeView_Previews: PreviewProvider {
    static var previews: some View {
        MetronomeView()
            .environmentObject(Metronome())
    }
}

//    Subdivision picker for now
struct RhythmPicker: View {
    @EnvironmentObject private var metronome: Metronome
    
    // Change it when work with rhythmic patterns will be done!!!!
    var body: some View {
        Picker("Subdivision", selection: $metronome.defaultSettings.subdivision) {
            
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
    
    var body: some View {
        Picker("Beat", selection: $metronome.defaultSettings.size) {
            ForEach(Size.allCases) { size in
                Text(String(describing: size.rawValue)).tag(size)
            }
        }
        .pickerStyle(.wheel)
        .frame(width: 85, height: 90)
        .background(.white)
        .cornerRadius(20)
    }
}

