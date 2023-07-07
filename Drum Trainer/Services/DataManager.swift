//
//  DataManager.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 04.07.2023.
//

import Foundation
import Combine

class DataManager: ObservableObject {
    var objectWillChange = ObservableObjectPublisher()
    
    @Published var defaultSettings = MetronomeSettings.defaultSettings
//    {
//        didSet {
//            objectWillChange.send()
//        }
//    }
    
//    @Published var defaultSettings = MetronomeSettings(
//        name: "DefaultAppSettings",
//        size: .four,
//        beat: 0,
//        tempo: 80,
//        subdivision: .quarter,
//        selectedBeats: [1 : .accent],
//        beatSelection: .accent
//    ) {
//        didSet {
//            objectWillChange.send()
//        }
//    }


        
    private func getDefaultMetronomePlaylist() -> [MetronomeSettings.ID: MetronomeSettings] {
        return [defaultSettings.id: defaultSettings]
    }
}
