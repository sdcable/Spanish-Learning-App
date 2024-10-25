//
//  SpanishLessonsModel.swift
//  LearnSpanish
//
//  Created by IS 543 on 10/24/24.
//

import Foundation

struct SpanishLesson {
    let topic: String
    let content: String
    let vocabulary: [[String: String]]
}

class SpanishLessonsModel{
    static let shared = SpanishLessonsModel()
    private init(){}
    
    let lessons: [String: SpanishLesson] = [
        
    ]
}
