//
//  SpanishLessonsModel.swift
//  LearnSpanish
//
//  Created by IS 543 on 10/24/24.
//

import Foundation

struct SpanishModel{
    struct SpanishLesson {
        let topic: String
        let content: String
        let vocabulary: [[String: String]]
    }

    struct QuizQuestion {
        let question: String
        let options: [String]
        let correctAnswer: String
    }

    let quizData: [String: [QuizQuestion]] = [
        "Basic Greetings and Farewells": [
            QuizQuestion(question: "What is the Spanish word for 'Hello'?", options: ["Hola", "Adiós", "Gracias"], correctAnswer: "Hola"),
            QuizQuestion(question: "What is the Spanish word for 'Goodbye'?", options: ["Adiós", "Hasta luego", "Buenos días"], correctAnswer: "Adiós"),
            QuizQuestion(question: "How do you say 'Good morning' in Spanish?", options: ["Buenos días", "Buenas noches", "Buenas tardes"], correctAnswer: "Buenos días"),
            QuizQuestion(question: "What is the phrase for 'How are you?' in Spanish?", options: ["¿Cómo estás?", "Estoy bien", "Hasta luego"], correctAnswer: "¿Cómo estás?"),
            QuizQuestion(question: "What is the correct response to '¿Cómo estás?' (How are you?)?", options: ["Adiós", "Estoy bien", "Hasta luego"], correctAnswer: "Estoy bien")
        ],
        
        "Common Phrases": [
            QuizQuestion(question: "How do you say 'Please' in Spanish?", options: ["Gracias", "De nada", "Por favor"], correctAnswer: "Por favor"),
            QuizQuestion(question: "What is the Spanish phrase for 'Thank you'?", options: ["Lo siento", "Gracias", "Me gustaría"], correctAnswer: "Gracias"),
            QuizQuestion(question: "What is the phrase for 'You're welcome' in Spanish?", options: ["De nada", "Gracias", "Por favor"], correctAnswer: "De nada"),
            QuizQuestion(question: "How do you say 'I'm sorry' in Spanish?", options: ["Lo siento", "Por favor", "Gracias"], correctAnswer: "Lo siento"),
            QuizQuestion(question: "What is the Spanish phrase for 'Where is...?'?", options: ["¿Dónde está...?", "¿Cuánto cuesta?", "Me gustaría"], correctAnswer: "¿Dónde está...?")
        ],
        
        "Numbers (1-10)": [
            QuizQuestion(question: "What is the Spanish word for '1'?", options: ["Uno", "Dos", "Tres"], correctAnswer: "Uno"),
            QuizQuestion(question: "How do you say '5' in Spanish?", options: ["Cuatro", "Cinco", "Seis"], correctAnswer: "Cinco"),
            QuizQuestion(question: "What is the Spanish word for '7'?", options: ["Ocho", "Seis", "Siete"], correctAnswer: "Siete"),
            QuizQuestion(question: "How do you say '9' in Spanish?", options: ["Ocho", "Diez", "Nueve"], correctAnswer: "Nueve"),
            QuizQuestion(question: "What is the Spanish word for '10'?", options: ["Cinco", "Diez", "Seis"], correctAnswer: "Diez")
        ],
        
        "Colors": [
            QuizQuestion(question: "What is the Spanish word for 'Red'?", options: ["Verde", "Azul", "Rojo"], correctAnswer: "Rojo"),
            QuizQuestion(question: "How do you say 'Blue' in Spanish?", options: ["Azul", "Rosa", "Naranja"], correctAnswer: "Azul"),
            QuizQuestion(question: "What is the Spanish word for 'Green'?", options: ["Verde", "Rojo", "Negro"], correctAnswer: "Verde"),
            QuizQuestion(question: "How do you say 'Black' in Spanish?", options: ["Negro", "Amarillo", "Blanco"], correctAnswer: "Negro"),
            QuizQuestion(question: "What is the Spanish word for 'White'?", options: ["Blanco", "Azul", "Naranja"], correctAnswer: "Blanco")
        ],
        "Family Members": [
            QuizQuestion(question: "What is the Spanish word for 'Mother'?", options: ["Madre", "Padre", "Hermano"], correctAnswer: "Madre"),
            QuizQuestion(question: "How do you say 'Father' in Spanish?", options: ["Tío", "Padre", "Abuelo"], correctAnswer: "Padre"),
            QuizQuestion(question: "What is the Spanish word for 'Brother'?", options: ["Hermano", "Tía", "Hermana"], correctAnswer: "Hermano"),
            QuizQuestion(question: "How do you say 'Sister' in Spanish?", options: ["Hermana", "Abuela", "Tío"], correctAnswer: "Hermana"),
            QuizQuestion(question: "What is the Spanish word for 'Grandfather'?", options: ["Abuelo", "Abuela", "Tía"], correctAnswer: "Abuelo")
            ],
            
        "Food and Drink": [
            QuizQuestion(question: "What is the Spanish word for 'Water'?", options: ["Agua", "Comida", "Té"], correctAnswer: "Agua"),
            QuizQuestion(question: "How do you say 'Food' in Spanish?", options: ["Comida", "Pan", "Fruta"], correctAnswer: "Comida"),
            QuizQuestion(question: "What is the Spanish word for 'Bread'?", options: ["Pan", "Carne", "Verdura"], correctAnswer: "Pan"),
            QuizQuestion(question: "How do you say 'Fruit' in Spanish?", options: ["Fruta", "Comida", "Té"], correctAnswer: "Fruta"),
            QuizQuestion(question: "What is the Spanish word for 'Coffee'?", options: ["Café", "Té", "Agua"], correctAnswer: "Café")
        ],
        
        "Common Adjectives": [
            QuizQuestion(question: "What is the Spanish word for 'Big'?", options: ["Grande", "Pequeño", "Bonito"], correctAnswer: "Grande"),
            QuizQuestion(question: "How do you say 'Small' in Spanish?", options: ["Pequeño", "Interesante", "Triste"], correctAnswer: "Pequeño"),
            QuizQuestion(question: "What is the Spanish word for 'Beautiful'?", options: ["Bonito", "Feo", "Feliz"], correctAnswer: "Bonito"),
            QuizQuestion(question: "How do you say 'Ugly' in Spanish?", options: ["Feo", "Bonito", "Triste"], correctAnswer: "Feo"),
            QuizQuestion(question: "What is the Spanish word for 'Happy'?", options: ["Triste", "Feliz", "Aburrido"], correctAnswer: "Feliz")
        ],
        
        "Days of the Week": [
            QuizQuestion(question: "What is the Spanish word for 'Monday'?", options: ["Martes", "Lunes", "Miércoles"], correctAnswer: "Lunes"),
            QuizQuestion(question: "How do you say 'Tuesday' in Spanish?", options: ["Miércoles", "Jueves", "Martes"], correctAnswer: "Martes"),
            QuizQuestion(question: "What is the Spanish word for 'Wednesday'?", options: ["Miércoles", "Viernes", "Sábado"], correctAnswer: "Miércoles"),
            QuizQuestion(question: "How do you say 'Thursday' in Spanish?", options: ["Jueves", "Lunes", "Domingo"], correctAnswer: "Jueves"),
            QuizQuestion(question: "What is the Spanish word for 'Sunday'?", options: ["Domingo", "Sábado", "Viernes"], correctAnswer: "Domingo")
        ],
        
        "Weather Vocabulary": [
            QuizQuestion(question: "How do you say 'It's sunny' in Spanish?", options: ["Hace sol", "Está nublado", "Llueve"], correctAnswer: "Hace sol"),
            QuizQuestion(question: "What is the Spanish phrase for 'It's cold'?", options: ["Hace frío", "Nieva", "Hace calor"], correctAnswer: "Hace frío"),
            QuizQuestion(question: "How do you say 'It's raining' in Spanish?", options: ["Llueve", "Hace sol", "Hace calor"], correctAnswer: "Llueve"),
            QuizQuestion(question: "What is the Spanish phrase for 'It's snowing'?", options: ["Nieva", "Hace frío", "Está nublado"], correctAnswer: "Nieva"),
            QuizQuestion(question: "How do you say 'It's hot' in Spanish?", options: ["Hace calor", "Hace frío", "Llueve"], correctAnswer: "Hace calor")
        ]

    ]
}


