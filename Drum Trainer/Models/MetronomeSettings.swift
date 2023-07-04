//
//  MetronomeSettings.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 01.06.2023.
//

struct MetronomeSettings {
    var metronome: Metronome
    var size: Size
    var beat: Int
    var tempo: Double
    var subdivision: Subdivision
    var selectedBeats: [Int: BeatSelection]
    
    init(metronome: Metronome, size: Size, beat: Int, tempo: Double, subdivision: Subdivision, selectedBeats: [Int : BeatSelection]) {
        self.metronome = metronome
        self.size = size
        self.beat = beat
        self.tempo = tempo
        self.subdivision = subdivision
        self.selectedBeats = selectedBeats
    }
}

enum Size: Int, CaseIterable, Identifiable {
    case two = 2
    case three = 3
    case four = 4
    case five = 5
    case six = 6
    case seven = 7
    case eight = 8
    
    var id: Self { self }
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
