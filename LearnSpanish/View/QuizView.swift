//
//  QuizView.swift
//  LearnSpanish
//
//  Created by IS 543 on 10/16/24.
//

import SwiftUI

struct QuizScreen: View {
    let topic: String
    @State private var selectedAnswers: [Int: String] = [:] // Track the user's selected answers
    @State private var showResults = false // Track whether to show results
    @State private var score = 0 // Track user's score
    
    var body: some View {
        VStack {
            Form {
                if let questions = QuizQuestion[topic] {
                    ForEach(0..<questions.count, id: \.self) { index in
                        let question = questions[index]
                        Section(header: Text(question.question)) {
                            ForEach(question.options, id: \.self) { option in
                                Button(action: {
                                    selectedAnswers[index] = option
                                }) {
                                    HStack {
                                        Text(option)
                                        Spacer()
                                        if selectedAnswers[index] == option {
                                            Image(systemName: "checkmark")
                                                .foregroundColor(.blue)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            Button("Submit") {
                calculateScore()
                showResults = true
            }
            .padding()
            .disabled(selectedAnswers.count < QuizQuestion[topic]?.count ?? 0) // Disable button if not all questions answered
            .alert(isPresented: $showResults) {
                Alert(title: Text("Quiz Results"), message: Text("You got \(score) out of \(QuizQuestion[topic]?.count ?? 0) correct!"), dismissButton: .default(Text("OK")))
            }
        }
        .navigationTitle("Quiz for \(topic)")
    }
    
    // Calculate the user's score based on their answers
    func calculateScore() {
        score = 0
        if let questions = QuizQuestion[topic] {
            for (index, question) in questions.enumerated() {
                if selectedAnswers[index] == question.correctAnswer {
                    score += 1
                }
            }
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
