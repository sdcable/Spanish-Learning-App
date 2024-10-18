//
//  SpanishViewModel.swift
//  LearnSpanish
//
//  Created by IS 543 on 10/18/24.
//

import Foundation

var soundPlayer = SoundPlayer()

@Observable class SpanishViewModel {
    func soundButtonPress(names: String) {
        var name = names
        Task{
            await soundPlayer.playSound(named: name)
        }
    }
}
