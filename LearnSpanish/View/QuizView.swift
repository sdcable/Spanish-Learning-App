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
            if let questions = QuizQuestion[topic], currentQuestionIndex < questions.count {
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
                                .cornerRadius(10)
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
                    
                    Text("Final Score: \(trackCorrectScore) / \(QuizQuestion[topic]?.count ?? 0)")
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
        if let questions = QuizQuestion[topic] {
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
        if currentQuestionIndex < (QuizQuestion[topic]?.count ?? 0) - 1 {
            currentQuestionIndex += 1
        } else {
            // If it's the last question, set currentQuestionIndex to a value beyond the last index
            currentQuestionIndex = QuizQuestion[topic]?.count ?? 0
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



let QuizQuestion: [String: [(question: String, options: [String], correctAnswer: String)]] = [
    "Basic Greetings and Farewells": [
        (question: "What is the Spanish word for 'Hello'?", options: ["Hola", "Adiós", "Gracias"], correctAnswer: "Hola"),
        (question: "What is the Spanish word for 'Goodbye'?", options: ["Adiós", "Hasta luego", "Buenos días"], correctAnswer: "Adiós"),
        (question: "How do you say 'Good morning' in Spanish?", options: ["Buenos días", "Buenas noches", "Buenas tardes"], correctAnswer: "Buenos días"),
        (question: "What is the phrase for 'How are you?' in Spanish?", options: ["¿Cómo estás?", "Estoy bien", "Hasta luego"], correctAnswer: "¿Cómo estás?"),
        (question: "What is the correct response to '¿Cómo estás?' (How are you?)?", options: ["Adiós", "Estoy bien", "Hasta luego"], correctAnswer: "Estoy bien")
    ],
    
    "Common Phrases": [
        (question: "How do you say 'Please' in Spanish?", options: ["Gracias", "De nada", "Por favor"], correctAnswer: "Por favor"),
        (question: "What is the Spanish phrase for 'Thank you'?", options: ["Lo siento", "Gracias", "Me gustaría"], correctAnswer: "Gracias"),
        (question: "What is the phrase for 'You're welcome' in Spanish?", options: ["De nada", "Gracias", "Por favor"], correctAnswer: "De nada"),
        (question: "How do you say 'I'm sorry' in Spanish?", options: ["Lo siento", "Por favor", "Gracias"], correctAnswer: "Lo siento"),
        (question: "What is the Spanish phrase for 'Where is...?'?", options: ["¿Dónde está...?", "¿Cuánto cuesta?", "Me gustaría"], correctAnswer: "¿Dónde está...?")
    ],
    
    "Numbers (1-10)": [
        (question: "What is the Spanish word for '1'?", options: ["Uno", "Dos", "Tres"], correctAnswer: "Uno"),
        (question: "How do you say '5' in Spanish?", options: ["Cuatro", "Cinco", "Seis"], correctAnswer: "Cinco"),
        (question: "What is the Spanish word for '7'?", options: ["Ocho", "Seis", "Siete"], correctAnswer: "Siete"),
        (question: "How do you say '9' in Spanish?", options: ["Ocho", "Diez", "Nueve"], correctAnswer: "Nueve"),
        (question: "What is the Spanish word for '10'?", options: ["Cinco", "Diez", "Seis"], correctAnswer: "Diez")
    ],
    
    "Colors": [
        (question: "What is the Spanish word for 'Red'?", options: ["Verde", "Azul", "Rojo"], correctAnswer: "Rojo"),
        (question: "How do you say 'Blue' in Spanish?", options: ["Azul", "Rosa", "Naranja"], correctAnswer: "Azul"),
        (question: "What is the Spanish word for 'Green'?", options: ["Verde", "Rojo", "Negro"], correctAnswer: "Verde"),
        (question: "How do you say 'Black' in Spanish?", options: ["Negro", "Amarillo", "Blanco"], correctAnswer: "Negro"),
        (question: "What is the Spanish word for 'White'?", options: ["Blanco", "Azul", "Naranja"], correctAnswer: "Blanco")
    ],
    "Family Members": [
            (question: "What is the Spanish word for 'Mother'?", options: ["Madre", "Padre", "Hermano"], correctAnswer: "Madre"),
            (question: "How do you say 'Father' in Spanish?", options: ["Tío", "Padre", "Abuelo"], correctAnswer: "Padre"),
            (question: "What is the Spanish word for 'Brother'?", options: ["Hermano", "Tía", "Hermana"], correctAnswer: "Hermano"),
            (question: "How do you say 'Sister' in Spanish?", options: ["Hermana", "Abuela", "Tío"], correctAnswer: "Hermana"),
            (question: "What is the Spanish word for 'Grandfather'?", options: ["Abuelo", "Abuela", "Tía"], correctAnswer: "Abuelo")
        ],
        
    "Food and Drink": [
        (question: "What is the Spanish word for 'Water'?", options: ["Agua", "Comida", "Té"], correctAnswer: "Agua"),
        (question: "How do you say 'Food' in Spanish?", options: ["Comida", "Pan", "Fruta"], correctAnswer: "Comida"),
        (question: "What is the Spanish word for 'Bread'?", options: ["Pan", "Carne", "Verdura"], correctAnswer: "Pan"),
        (question: "How do you say 'Fruit' in Spanish?", options: ["Fruta", "Comida", "Té"], correctAnswer: "Fruta"),
        (question: "What is the Spanish word for 'Coffee'?", options: ["Café", "Té", "Agua"], correctAnswer: "Café")
    ],
    
    "Common Adjectives": [
        (question: "What is the Spanish word for 'Big'?", options: ["Grande", "Pequeño", "Bonito"], correctAnswer: "Grande"),
        (question: "How do you say 'Small' in Spanish?", options: ["Pequeño", "Interesante", "Triste"], correctAnswer: "Pequeño"),
        (question: "What is the Spanish word for 'Beautiful'?", options: ["Bonito", "Feo", "Feliz"], correctAnswer: "Bonito"),
        (question: "How do you say 'Ugly' in Spanish?", options: ["Feo", "Bonito", "Triste"], correctAnswer: "Feo"),
        (question: "What is the Spanish word for 'Happy'?", options: ["Triste", "Feliz", "Aburrido"], correctAnswer: "Feliz")
    ],
    
    "Days of the Week": [
        (question: "What is the Spanish word for 'Monday'?", options: ["Martes", "Lunes", "Miércoles"], correctAnswer: "Lunes"),
        (question: "How do you say 'Tuesday' in Spanish?", options: ["Miércoles", "Jueves", "Martes"], correctAnswer: "Martes"),
        (question: "What is the Spanish word for 'Wednesday'?", options: ["Miércoles", "Viernes", "Sábado"], correctAnswer: "Miércoles"),
        (question: "How do you say 'Thursday' in Spanish?", options: ["Jueves", "Lunes", "Domingo"], correctAnswer: "Jueves"),
        (question: "What is the Spanish word for 'Sunday'?", options: ["Domingo", "Sábado", "Viernes"], correctAnswer: "Domingo")
    ],
    
    "Weather Vocabulary": [
        (question: "How do you say 'It's sunny' in Spanish?", options: ["Hace sol", "Está nublado", "Llueve"], correctAnswer: "Hace sol"),
        (question: "What is the Spanish phrase for 'It's cold'?", options: ["Hace frío", "Nieva", "Hace calor"], correctAnswer: "Hace frío"),
        (question: "How do you say 'It's raining' in Spanish?", options: ["Llueve", "Hace sol", "Hace calor"], correctAnswer: "Llueve"),
        (question: "What is the Spanish phrase for 'It's snowing'?", options: ["Nieva", "Hace frío", "Está nublado"], correctAnswer: "Nieva"),
        (question: "How do you say 'It's hot' in Spanish?", options: ["Hace calor", "Hace frío", "Llueve"], correctAnswer: "Hace calor")
    ]
]
