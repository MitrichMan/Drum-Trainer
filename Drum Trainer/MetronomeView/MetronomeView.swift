//
//  MetronomeView.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 31.05.2023.
//

import SwiftUI

struct MetronomeView: View {
    @EnvironmentObject private var metronome: Metronome
    
    @StateObject var viewModel = MetronomeViewModel()
        
    var body: some View {
        ZStack{
            Color(viewModel.backgroundColor)
                .ignoresSafeArea()
            
            VStack {
                Spacer(minLength: 20)
                
                BeatLightsView(
                    viewModel: BeatLightsViewModel(
                        beat: metronome.beat,
                        size: viewModel.size
                    )
                )
                .environmentObject(metronome)
                .padding(.bottom)

                HStack {
                    
                    VStack(spacing: 1) {
                        SizePickerView(
                            size: $viewModel.size,
                            metronome: metronome
                        )
                        RhythmPicker(
                            subdivision: $viewModel.subdivision,
                            metronome: metronome
                        )
                    }
                    .padding(.leading, 20)
                    
                    Spacer()
                    
                    Text(metronome.beat.formatted())
                        .font(.largeTitle)
                                        
                    Spacer(minLength: 185)
                    
                }
                
                ControlWheelView(
                    tempo: $viewModel.tempo,
                    bigCircleDiameter: viewModel.bigCircleDiameter,
                    startMetronome: viewModel.startButtonWasTapped
                )
                .onChange(of: viewModel.tempo) { newValue in
                    metronome.tempo = viewModel.tempo
                }
                
                Spacer(minLength: 50)
            }
        }
        .onAppear {
            viewModel.metronome = metronome
        }
    }
    
//    private func startButtonWasTapped() {
//        metronome.buttonWasTapped(
//            tempo: viewModel.tempo,
//            size: viewModel.size.rawValue,
//            subdivision: viewModel.subdivision.rawValue
//        )
//        metronome.size = viewModel.size.rawValue
//        metronome.subdivision = viewModel.subdivision.rawValue
//    }
}

struct MetronomeView_Previews: PreviewProvider {
    static var previews: some View {
        MetronomeView()
    }
}

struct RhythmPicker: View {
///    Subdivision picker for now
    @Binding var subdivision: Subdivision
    
    var metronome: Metronome
    
/// I will change it when i will work on rhythmic patterns
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
        .onChange(of: subdivision) { newValue in
            metronome.subdivision = subdivision
        
        }
    }
}

struct SizePickerView: View {

    @Binding var size: Size
//    @Binding var subdivision: Subdivision

    var metronome: Metronome

    var body: some View {
//        Picker("Beat", selection: $size) {
//            Text(Size.two.rawValue.formatted()).tag(Size.two)
//            Text(Size.three.rawValue.formatted()).tag(Size.three)
//            Text(Size.four.rawValue.formaztted()).tag(Size.four)
//            Text(Size.five.rawValue.formatted()).tag(Size.five)
//            Text(Size.six.rawValue.formatted()).tag(Size.six)
//            Text(Size.seven.rawValue.formatted()).tag(Size.seven)
//            Text(Size.eight.rawValue.formatted()).tag(Size.eight)
//        }
        Picker("Beat", selection: $size) {
            ForEach(Size.allCases) { size in
                Text(String(describing: size.rawValue)).tag(size)
            }
        }
        .pickerStyle(.wheel)
        .frame(width: 100, height: 50)
        .background(.white)
        .cornerRadius(20)
        .onChange(of: size) { newValue in
            metronome.size = size
            print(metronome.size.rawValue.formatted())
        }
    }

}

