//
//  QuizView.swift
//  LearnSpanish
//
//  Created by IS 543 on 10/16/24.
//

import SwiftUI
import AVFoundation

struct QuizScreen: View {
    // For the animation
    @State private var progress: CGFloat = 1.0
    @State private var timer: Timer?
    let totalDuration: TimeInterval = 20
    
    // For Spin
    @State private var shouldSpin = false
    
    // For Quiz
    let topic: String
    @State private var selectedAnswers: [Int: String] = [:]
    @State private var currentQuestionIndex = 0
    @State private var score = 0
    @State private var trackCorrectScore = 0
    @State private var isCorrect = false
    @State private var showFeedback = false
    var spanishViewModel: SpanishViewModel
    
    // High Score
    @State private var highScore = 0  // Track the high score
    
    @State private var elapsedTime: TimeInterval = 20
    
    var body: some View {
        GeometryReader { geometry in
            if let questions = spanishViewModel.getQuizQuestions(for: topic), currentQuestionIndex < questions.count {
                VStack {
                    Text("High Score: \(highScore)")
                        .font(.headline)
                        .padding(.top)
                        .padding(.horizontal)
                    
                    Text("Answers Correct: \(trackCorrectScore)/\(currentQuestionIndex)")
                        .font(.headline)
                    
                    Text("Current Score: \(score)")
                    
                    Text("Question \(currentQuestionIndex + 1) of \(questions.count)")
                        .font(.headline)
                        .padding()
                    
                    Text(questions[currentQuestionIndex].question)
                        .font(.title)
                        .padding()
                    
                    LineProgress(progress: progress)
                        .stroke(Color.blue, lineWidth: 5)
                        .frame(height: 5)
                        .padding()
                    
                    // Countdown timer text
                    Text("Time remaining: \(Int(elapsedTime)) seconds")
                        .font(.title2)
                        .foregroundColor(elapsedTime > 5 ? .black : .red) // Change color based on time
                        .padding()
                    
                    
                    
                    ForEach(questions[currentQuestionIndex].options, id: \.self) { option in
                        Button(action: {
                            checkAnswer(selected: option)
                        }) {
                            Text(option)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(11)
                                .padding(.horizontal)
                        }
                    }
                    
                    Spacer()
                }
                .navigationTitle("Quiz for \(topic)")
                .sheet(isPresented: $showFeedback, onDismiss: moveToNextQuestion) {
                    VStack {
                        Text(isCorrect ? "Correct!" : "Wrong!")
                            .font(.largeTitle)
                            .padding()
                        
                        Text("Total points so far: \(score)")
                            .padding(.bottom)
                        
                        Button("Next") {
                            showFeedback = false
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }
                .onAppear {
                    loadHighScore()
                    resetTimer()
                }
                .frame(minHeight: 0, maxHeight: .infinity)
                .cardify(isFaceUp: true)
                .rotationEffect(Angle.degrees(shouldSpin ? 360 : 0))
            } else {
                VStack {
                    Text("Quiz Finished!")
                        .font(.largeTitle)
                        .padding()
                    
                    Text("Final Score: \(trackCorrectScore) / \(currentQuestionIndex)")
                    Text("Total Points: \(score)")
                        .padding(.bottom)
                    
                    if score > highScore {
                        Text("New High Score!")
                            .font(.headline)
                            .foregroundColor(.green)
                            .padding()
                        Button("Save High Score") {
                            saveHighScore()
                        }
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    
                    Button(action: {
                        resetQuiz()
                    }) {
                        Text("Retry")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                }
                .frame(minHeight: 0, maxHeight: .infinity)
                .cardify(isFaceUp: true)
                .onAppear {
                    if trackCorrectScore == 5 {
                        spanishViewModel.saveCompletionState(for: "\(topic)_quiz", isCompleted: true)
                    }
                }
            }
        }
        .padding()
    }
    
    // Check the user's answer and show feedback
    func checkAnswer(selected option: String) {
        timer?.invalidate()
        if let questions = spanishViewModel.getQuizQuestions(for: topic) {
            let correctAnswer = questions[currentQuestionIndex].correctAnswer
            isCorrect = (option == correctAnswer)
            
            if isCorrect {
                score += 10
                trackCorrectScore += 1
                
                let bonus = Int(ceil(max(0, (elapsedTime) / 2)))
                score += bonus
                
                playSound(correct: true)
                withAnimation(.easeInOut(duration: 1.0)){
                    shouldSpin = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                    showFeedback = true
                }
            } else {
                playSound(correct: false)
                showFeedback = true
            }
            
        }
    }
    
    // Move to the next question
    func moveToNextQuestion() {
        showFeedback = false
        if currentQuestionIndex < (spanishViewModel.getQuizQuestions(for: topic)?.count ?? 0) - 1 {
            currentQuestionIndex += 1
        } else {
            // If it's the last question, set currentQuestionIndex to a value beyond the last index
            currentQuestionIndex = spanishViewModel.getQuizQuestions(for: topic)?.count ?? 0
        }
        shouldSpin = false
        resetTimer()
    }
    
    // Play correct or incorrect sound
    func playSound(correct: Bool) {
        let soundName = correct ? "correct.mp3" : "wrong.m4a"
        spanishViewModel.soundButtonPress(names:soundName)
    }
    
    // Reset quiz to start over
    func resetQuiz() {
        selectedAnswers = [:]
        currentQuestionIndex = 0
        score = 0
        trackCorrectScore = 0
        resetTimer()
    }
    
    func resetTimer() {
            timer?.invalidate()
            progress = 1.0  // Reset progress
            elapsedTime = 20
            
            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                elapsedTime -= 0.1
                withAnimation(.linear(duration: 0.1)) {
                    self.progress -= CGFloat(0.1 / totalDuration)
                }
                
                if self.progress <= 0 {
                    self.timer?.invalidate()
                }
            }
        }
    
    func loadHighScore() {
            highScore = UserDefaults.standard.integer(forKey: "\(topic)_highScore")
        }
        
        func saveHighScore() {
            if score > highScore {
                highScore = score
                UserDefaults.standard.set(highScore, forKey: "\(topic)_highScore")
            }
        }

}
