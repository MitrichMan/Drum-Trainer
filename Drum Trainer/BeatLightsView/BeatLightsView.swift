//
//  BeatLightsView.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 20.06.2023.
//

import SwiftUI

struct BeatLightsView: View {
    @Binding var size: Size
    
    let beat: Int
    
    var body: some View {
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
                            beat: beat,
                            index: index
                        ))
                        .padding(10)
                }
            }
        }
    }
    
    private func changeBeatCircleColor(beat: Int, index: Int) -> Color {
        let color: Color

        if beat == index {
            color = .red
        } else {
            color = Color("BackgroundColor")
        }
        return color
    }
}

struct BeatLightsView_Previews: PreviewProvider {
    static var previews: some View {
        BeatLightsView(size: .constant(Size.four), beat: 3)
    }
}
