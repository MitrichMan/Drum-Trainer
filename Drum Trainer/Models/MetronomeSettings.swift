//
//  MetronomeSettings.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 01.06.2023.
//

struct MetronomeSettings {
    enum Size: Int {
        case two = 2
        case three = 3
        case four = 4
        case five = 5
    }
    
    let size: Int
    let beat: Int
    let tempo: Double
}
