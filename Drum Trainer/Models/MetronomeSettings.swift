//
//  MetronomeSettings.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 01.06.2023.
//

struct MetronomeSettings {
    let metronome: Metronome
    let size: Size
    let beat: Int
    let tempo: Double
    let subDivision: Subdivision
    let beatSelection: BeatSelection
    let selectedBeats: [Int: BeatSelection]
}

enum Size: Int, CaseIterable {
    case two = 2
    case three = 3
    case four = 4
    case five = 5
    case six = 6
    case seven = 7
    case eight = 8
}

enum Subdivision: Int {
    case half = 2
    case quarter = 4
    case eighth = 8
    case sixteenth = 16
}

enum BeatSelection {
    case accent
    case weak
    case ghost
}
