//
//  Drum_TrainerApp.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 31.05.2023.
//

import SwiftUI

@main
struct Drum_TrainerApp: App {
    @ObservedObject var metronome = Metronome()
    @ObservedObject var dataManager = DataManager()
    
    var body: some Scene {
        WindowGroup {
            MetronomeView()
                .environmentObject(metronome)
                .environmentObject(dataManager)
                .onAppear{
                    metronome.dataManager = dataManager
                }
        }
    }
}
