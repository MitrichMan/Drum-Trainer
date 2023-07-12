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
    @StateObject private var dataManager = DataManager.shared
    
    var body: some Scene {
        WindowGroup {
            MetronomeView()
                .environmentObject(metronome)
                .environmentObject(dataManager)
                .onAppear {
                    metronome.dataManager = dataManager
                }
        }
    }
}
