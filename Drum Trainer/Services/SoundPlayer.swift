//
//  SoundPlayer.swift
//  Drum Trainer
//
//  Created by Dmitrii Melnikov on 26.06.2023.
//

import UIKit
import AVFAudio

class SoundPlayer {
    var player: AVAudioPlayer?
    
    func playSound(beat: BeatSelection) {
        guard let url = NSDataAsset(name: soundChoice(beat: beat))?.data else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(data: url)
            guard let player = player else { return }
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    private func soundChoice(beat: BeatSelection) -> String {
        switch beat {
        case .accent:
            return "MetronomeBeep"
        case .weak:
            return "MetronomeBeepLow"
        case .ghost:
            return "Clip"
        }
    }
}
