//
//  AccentNimbusView.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 04.07.2023.
//

import SwiftUI

struct AccentNimbusView: View {
    let beatSelection: BeatSelection
    let color: Color
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(color)
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
