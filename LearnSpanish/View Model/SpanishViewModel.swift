//
//  SpanishViewModel.swift
//  LearnSpanish
//
//  Created by IS 543 on 10/18/24.
//

import Foundation

var soundPlayer = SoundPlayer()

@Observable class SpanishViewModel {
    // MARK: - Properties
    private let visitedLessonsKey = "visitedLessons"
    private var spanishModel = SpanishModel()
    
    // Fetch visited lessons from UserDefaults
    private var visitedLessons: Set<String> {
        get {
            return Set(UserDefaults.standard.stringArray(forKey: visitedLessonsKey) ?? [])
        }
        set {
            UserDefaults.standard.set(Array(newValue), forKey: visitedLessonsKey)
        }
    }
    
    func getTopics() -> [String] {
        spanishModel.topics
    }
    
    
    // MARK: - Model access
    
    
    // Save the completion state for a topic in UserDefaults
    func saveCompletionState(for topic: String, isCompleted: Bool) {
        UserDefaults.standard.set(isCompleted, forKey: topic)
    }
    
    // Load the completion state for a topic from UserDefaults
    func loadCompletionState(for topic: String) -> Bool {
        return UserDefaults.standard.bool(forKey: topic)
    }
    
    
    func isLessonVisited(_ topic: String) -> Bool {
        visitedLessons.contains(topic)
    }
    
    // MARK: - User intents
    func markLessonAsVisited(_ topic: String) {
        visitedLessons.insert(topic)
    }
    
    func soundButtonPress(names: String) {
        let name = names
        Task {
            await soundPlayer.playSound(named: name)
        }
    }
    
    func getQuizQuestions(for topic: String) -> [SpanishModel.QuizQuestion]? {
        return spanishModel.quizData[topic]
    }
    
    func getSpanishLesson(for topic: String) -> String? {
        return spanishModel.spanishLessons[topic]
    }
    
    func getVocabList(for topic: String) -> [[String: String]]? {
        return spanishModel.vocabulary[topic]
    }
      
    
    // MARK: - Private Helpers
}


