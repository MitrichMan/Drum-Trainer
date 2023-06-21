//
//  MetronomeView.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 31.05.2023.
//

import SwiftUI

enum Size: Int {
    case two = 2
    case three = 3
    case four = 4
    case five = 5
}

enum Subdivision {
    case second
    case fourth
    case eighth
    case sixteenth
}

enum BeatSelection {
    case accent
    case weak
    case ghost
}

struct MetronomeView: View {
    @StateObject var metronome = Metronome()
    
    @State private var tempo = 80.0 
    @State private var size: Size = .four
            
    private let backgroundColor = UIColor(named: "BackgroundColor") ?? .systemGray5
    
    private let bigCircleDiameter: CGFloat = 350
    
    var body: some View {
        ZStack{
            Color(backgroundColor)
                .ignoresSafeArea()
            
            VStack {
                Spacer(minLength: 20)
                
                BeatLightsView(size: $size, beat: metronome.beat)
                    .padding(.bottom)

                HStack {
                    SizePickerView(size: $size, metronome: metronome)
                        .padding(.leading, 50)

                    Spacer()
                    
                    Text(metronome.beat.formatted())
                        .font(.largeTitle)
                    
                    Spacer(minLength: 188)
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
        metronome.buttonWasTapped(tempo: tempo)
        metronome.size = size.rawValue
    }
}

struct MetronomeView_Previews: PreviewProvider {
    static var previews: some View {
        MetronomeView()
    }
}

struct SizePickerView: View {

    @Binding var size: Size

    var metronome: Metronome

    var body: some View {
        VStack {
            Picker("Beat", selection: $size) {
                Text("2").tag(Size.two)
                    .rotationEffect(Angle(degrees: 90))
                Text("3").tag(Size.three)
                    .rotationEffect(Angle(degrees: 90))
                Text("4").tag(Size.four)
                    .rotationEffect(Angle(degrees: 90))
                Text("5").tag(Size.five)
                    .rotationEffect(Angle(degrees: 90))
            }
            .pickerStyle(.wheel)
            .frame(width: 30, height: 30)
//            .background(.white)
            .cornerRadius(20)
//            .padding(.leading, 20)
            .onChange(of: size) { newValue in
                metronome.size = size.rawValue
            }
        .rotationEffect(Angle(degrees: -90))

            Picker("Beat", selection: $size) {
                Text("2").tag(Subdivision.second)
                    .rotationEffect(Angle(degrees: 90))
                Text("4").tag(Subdivision.fourth)
                    .rotationEffect(Angle(degrees: 90))
                Text("8").tag(Subdivision.eighth)
                    .rotationEffect(Angle(degrees: 90))
                Text("16").tag(Subdivision.sixteenth)
                    .rotationEffect(Angle(degrees: 90))
            }
            .pickerStyle(.wheel)
            .frame(width: 30, height: 30)
//            .background(.white)
            .cornerRadius(20)
//            .padding(.leading, 20)
            .onChange(of: size) { newValue in
                metronome.size = size.rawValue
            }
        .rotationEffect(Angle(degrees: -90))
        }
    }
}

