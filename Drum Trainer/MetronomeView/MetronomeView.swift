//
//  MetronomeView.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 31.05.2023.
//

import SwiftUI

struct MetronomeView: View {
    @StateObject var metronome = Metronome()
    
    @State private var tempo = 80.0 
    @State private var size: Size = .four
    @State private var subdivision: Subdivision = .quarter
            
    private let backgroundColor = UIColor(named: "BackgroundColor") ?? .systemGray5
    
    private let bigCircleDiameter: CGFloat = 350
    
    var body: some View {
        ZStack{
            Color(backgroundColor)
                .ignoresSafeArea()
            
            VStack {
                Spacer(minLength: 20)
                
                BeatLightsView(
                    viewModel: BeatLightsViewModel(
                        metronome: metronome,
                        beat: metronome.beat,
                        size: size),
                    size: $size,
                    beat: metronome.beat,
                    metronome: metronome
                )
                    .padding(.bottom)

                HStack {
                    
                    VStack(spacing: 1) {
                        SizePickerView(
                            size: $size,
//                            subdivision: $subdivision,
                            metronome: metronome
                        )
                        RhythmPicker(
                            subdivision: $subdivision,
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
                    tempo: $tempo,
                    bigCircleDiameter: bigCircleDiameter,
                    startMetronome: startButtonWasTapped
                )
                .onChange(of: tempo) { newValue in
                    metronome.tempo = tempo
                }
                
                Spacer(minLength: 50)
            }
        }
    }
    
    private func startButtonWasTapped() {
        metronome.buttonWasTapped(
            tempo: tempo,
            size: size.rawValue,
            subdivision: subdivision.rawValue
        )
        metronome.size = size.rawValue
        metronome.subdivision = subdivision.rawValue
    }
}

struct MetronomeView_Previews: PreviewProvider {
    static var previews: some View {
        MetronomeView()
    }
}

struct RhythmPicker: View {
//    Subdivision picker for now
    @Binding var subdivision: Subdivision
    
    var metronome: Metronome
    
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
            metronome.subdivision = subdivision.rawValue
        
        }
    }
}

struct SizePickerView: View {

    @Binding var size: Size
//    @Binding var subdivision: Subdivision

    var metronome: Metronome

    var body: some View {
        Picker("Beat", selection: $size) {
            Text(Size.two.rawValue.formatted()).tag(Size.two)
            Text(Size.three.rawValue.formatted()).tag(Size.three)
            Text(Size.four.rawValue.formatted()).tag(Size.four)
            Text(Size.five.rawValue.formatted()).tag(Size.five)
            Text(Size.six.rawValue.formatted()).tag(Size.six)
            Text(Size.seven.rawValue.formatted()).tag(Size.seven)
            Text(Size.eight.rawValue.formatted()).tag(Size.eight)
        }
        .pickerStyle(.wheel)
        .frame(width: 100, height: 50)
        .background(.white)
        .cornerRadius(20)
        .onChange(of: size) { newValue in
            metronome.size = size.rawValue
        }
    }

}

