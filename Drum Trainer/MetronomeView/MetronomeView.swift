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
    case six = 6
    case seven = 7
    case eight = 8
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
        Picker("Beat", selection: $size) {
            Text("2/4").tag(Size.two)
            Text("3/4").tag(Size.three)
            Text("4/4").tag(Size.four)
            Text("5/4").tag(Size.five)
            Text("6/4").tag(Size.six)
            Text("7/4").tag(Size.seven)
            Text("8/4").tag(Size.eight)
        }
        .pickerStyle(.wheel)
        .frame(width: 100, height: 100)
        .background(.white)
        .cornerRadius(20)
        .padding(.leading, 20)
        .onChange(of: size) { newValue in
            metronome.size = size.rawValue
        }
    }
}

