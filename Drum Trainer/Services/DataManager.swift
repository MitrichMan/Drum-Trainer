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
    
    @Published var defaultSettings = MetronomeSettings.defaultSettings {
        didSet {
            objectWillChange.send()
        }
    }
        
    private func getDefaultMetronomePlaylist() -> [MetronomeSettings.ID: MetronomeSettings] {
        return [defaultSettings.id: defaultSettings]
    }
}
