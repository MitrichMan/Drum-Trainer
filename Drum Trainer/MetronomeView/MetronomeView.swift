//
//  MetronomeView.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 31.05.2023.
//

import SwiftUI

struct MetronomeView: View {
    
    enum Size: Int {
        case two = 2
        case three = 3
        case four = 4
        case five = 5
    }
    
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
                Spacer(minLength: 30)

                ZStack {
                    Rectangle()
                        .frame(width: 350, height: 200)
                        .foregroundColor(.white)
                        .cornerRadius(30)
                    HStack {
                        ForEach((1...size.rawValue), id: \.self) { index in
                            Circle()
                                .tag(index)
                                .frame(width: 40)
                                .foregroundColor(changeBeatCircleColor(
                                    beat: metronome.beat,
                                    index: index
                                ))
                                .padding(10)
                        }
                    }
                }
                
                HStack {
                    Picker("Beat", selection: $size) {
                        Text("2/4").tag(Size.two)
                        Text("3/4").tag(Size.three)
                        Text("4/4").tag(Size.four)
                        Text("5/4").tag(Size.five)
                    }
                    .pickerStyle(.wheel)
                    .frame(width: 100, height: 100)
                    .background(.white)
                    .cornerRadius(20)
                    .padding(.leading, 20)
                    
                    Spacer()
                    
                    Text(metronome.beat.formatted())
                        .font(.largeTitle)
                    
                    Spacer(minLength: 188)
                }
                
                MetronomeViewPrototype(
                    tempo: $tempo,
                    bigCircleDiameter: bigCircleDiameter,
                    startMetronome: startButtonWasTapped
                )
                
                Spacer(minLength: 50)
            }
        }
    }
    
    private func startButtonWasTapped() {
        metronome.buttonWasTapped(tempo: tempo)
        metronome.size = size.rawValue
    }
    
    private func changeBeatCircleColor(beat: Int, index: Int) -> Color {
        let color: Color
        
        if beat == index {
            color = .red
        } else {
            color = .gray
        }
        return color
    }
}

struct MetronomeView_Previews: PreviewProvider {
    static var previews: some View {
        MetronomeView()
    }
}
