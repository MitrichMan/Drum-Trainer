//
//  Drum_TrainerApp.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 31.05.2023.
//

import SwiftUI

@main
struct Drum_TrainerApp: App {
    @StateObject private var metronome = Metronome()
    
    var body: some Scene {
        WindowGroup {
            MetronomeView()
                .environmentObject(metronome)
                
        }
    }
}
