//
//  PersistentProgress.swift
//  LearnSpanish
//
//  Created by IS 543 on 10/17/24.
//

import Foundation

typealias ItemProgress = [String: Bool]
typealias TopicProgress = [String: ItemProgress]

let myProgress: TopicProgress = [
    "topic1": ["read":false, "studied":false, "passed":false],
    "topic2": ["read":false, "studied":false, "passed":false],
    ]



//struct PersistentProgress {
//    private static func defaultProgress() -> TopicProgress {
//        var defaultProgress: TopicProgress = [:]
//        
//        for topic in myProgress.keys {
//            defaultProgress[topic] =
//                "read" = false;,
//                "studied" = false,
//                "passed" = false
//        }
//    }
    
//    private static func readProgress() -> TopicProgress {
//        UserDefaults.standard.dictionary(forKey: Key.progress) as? TopicProgress ?? defaultProgress()
//    }
//    
//    var progress = PersistentProgress.readProgress()
        
        
//    {
//        didSet {
//            UserDefaults.standard.set(progress, forKey: Key.progress)
//        }
//    }

    private struct Key {
        static let progress = "Progress"
        static let highScores = "HighScores"
    }
//}
