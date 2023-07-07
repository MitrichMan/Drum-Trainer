//
//  MetronomeSettings.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 01.06.2023.
//

// CRUD!!!!!!!!!!!

struct MetronomeSettings: Identifiable {
    var id: String
    var name: String
    var size: Size
    var beat: Int
    var tempo: Double 
    var subdivision: Subdivision
    var selectedBeats: [Int: BeatSelection]
    var beatSelection: BeatSelection
    
    init(name: String, size: Size, beat: Int, tempo: Double, subdivision: Subdivision, selectedBeats: [Int : BeatSelection],  beatSelection: BeatSelection) {
        id = name
        self.name = name
        self.size = size
        self.beat = beat
        self.tempo = tempo
        self.subdivision = subdivision
        self.selectedBeats = selectedBeats
        self.beatSelection = beatSelection
    }
}

extension MetronomeSettings {
    static var defaultSettings = MetronomeSettings(
        name: "DefaultAppSettings",
        size: .four,
        beat: 0,
        tempo: 80,
        subdivision: .quarter,
        selectedBeats: [1 : .accent],
        beatSelection: .accent
    )
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

enum Subdivision: Int, CaseIterable, Identifiable  {
    case half = 2
    case quarter = 4
    case eighth = 8
    case sixteenth = 16
    
    var id: Self { self }
}

enum BeatSelection {
    case accent
    case weak
    case ghost
}
