//
//  BeatLightsView.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 20.06.2023.
//

import SwiftUI

struct BeatLightsView: View {
    @Binding var size: Size
    
    @State private var selectedBeats: [Int: BeatSelection] = [1: .accent]
    
//    @State var circleDiameter = 40.0
    
    let beat: Int
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 350, height: 200)
                .foregroundColor(.white)
                .cornerRadius(30)
            HStack {
                ForEach((1...size.rawValue), id: \.self) { index in
                    ZStack {
                        AccentNimbusView(beatSelection: selectedBeats[index] ?? .weak)
                        
                        Circle()
                            .tag(index)
                            .frame(width: setUpCircleAppearance(index: index))
                            .foregroundColor(playingBeatCircleColorSetUp(
                                beat: beat,
                                index: index
                            ))
                            .padding(10)
                            .onTapGesture {
                                selectBeats(from: index)
//                                setUpCircleAppearance(index: index)
                            }
                            .onAppear {
                                setUpBeatSelection()
//                                setUpCircleAppearance(index: index)
                            }
                    }
                }
            }
        }
    }
    
    private func playingBeatCircleColorSetUp(beat: Int, index: Int) -> Color {
        let color: Color
        
        if beat == index {
            switch selectedBeats[index] {
            case .accent:
                color = .green
            case .weak:
                color = .red
            case .ghost:
                color = .yellow
            default:
                color = Color("BackgroundColor")
            }
        } else {
            color = Color("BackgroundColor")
        }
        
        return color
    }
    
    private func setUpBeatSelection() {
        for beat in 2...size.rawValue {
            selectedBeats[beat] = .weak
        }
    }
    
    private func setUpCircleAppearance(index: Int) -> Double {
        let circleDiameter: Double
        
        switch selectedBeats[index] {
        case .accent:
            circleDiameter = 40
        case .weak:
            circleDiameter = 40
        case .ghost:
            circleDiameter = 16
        default:
            circleDiameter = 40
        }
        
        return circleDiameter
    }
    
    private func selectBeats(from index: Int) {
        switch selectedBeats[index] {
        case .accent:
            selectedBeats[index] = .ghost
        case .weak:
            selectedBeats[index] = .accent
        default:
            selectedBeats[index] = .weak
        }
    }
}

struct BeatLightsView_Previews: PreviewProvider {
    static var previews: some View {
        BeatLightsView(size: .constant(Size.four), beat: 3)
    }
}

struct AccentNimbusView: View {
    let beatSelection: BeatSelection
        
    var body: some View {
            ZStack {
                Circle()
                    .foregroundColor(Color("BackgroundColor"))
                    .frame(width: 52)
                Circle()
                    .foregroundColor(.white)
                    .frame(width: 46)
            }
            .opacity(setUpOpacity())
    }
    
    private func setUpOpacity() -> Double {
        let opacity: Double
        if beatSelection == .accent {
            opacity = 1.0
        } else {
            opacity = 0.0
        }
        return opacity
    }
}
