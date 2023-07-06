//
//  BeatCircleView.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 04.07.2023.
//

import SwiftUI

struct BeatCircleView: View {
    let playingBeatCircleColor: Color

    let circleDiameter: Double
    
    var body: some View {
        Circle()
            .frame(width: circleDiameter)
            .foregroundColor(playingBeatCircleColor)
    }
}
