//
//  DataManager.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 04.07.2023.
//

import Foundation
import Combine

class DataManager: ObservableObject {
    static let shared = DataManager()
    
    var defaultSettings = MetronomeSettings(
        name: "",
        size: .four,
        beat: 0,
        tempo: 80,
        subdivision: .quarter,
        selectedBeats: [1: .accent],
        beatSelection: .accent
    )
    
    
    let objectWillChange = ObservableObjectPublisher()
    
    private init () {}
    
//    private func getDefaultMetronomePlaylist() -> [MetronomeSettings.ID: MetronomeSettings] {
//        return [defaultSettings.id: defaultSettings]
//    }
}
