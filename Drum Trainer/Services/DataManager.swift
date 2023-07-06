//
//  DataManager.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 04.07.2023.
//

import Foundation
import Combine

class DataManager: ObservableObject {
    var objectWillChange = PassthroughSubject<DataManager, Never>()
    
    var settings = MetronomeSettings(
        size: .four,
        beat: 0,
        tempo: 80,
        subdivision: .quarter,
        selectedBeats: [1: .accent]
    ) {
        didSet {
            objectWillChange.send(self)
        }
    }
}
