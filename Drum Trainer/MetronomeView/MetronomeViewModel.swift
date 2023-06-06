//
//  MetronomeViewModel.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 01.06.2023.
//

import Foundation

class MetronomeViewModel: ObservableObject {
    
    var tempo: Double {
        settings.tempo
    }
    
    var size: Int {
        settings.size
    }
    
    private let settings: MetronomeSettings
    
    init(settings: MetronomeSettings) {
        self.settings = settings
    }

}
