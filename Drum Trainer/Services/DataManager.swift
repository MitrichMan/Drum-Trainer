//
//  DataManager.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 04.07.2023.
//

import Combine

class DataManager: ObservableObject {
    @Published var defaultSettings: MetronomeSettings = MetronomeSettings.getDefaultSettings() {
        didSet {
            objectWillChange.send()
        }
    }
    
    let objectWillChange = ObservableObjectPublisher()
    
    static let shared = DataManager()
    
    private init () {}
    
//    private func getDefaultMetronomePlaylist() -> [MetronomeSettings.ID: MetronomeSettings] {
//        return [defaultSettings.id: defaultSettings]
//    }
}
