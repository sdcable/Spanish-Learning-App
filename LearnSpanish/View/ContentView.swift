//
//  ContentView.swift
//  LearnSpanish
//
//  Created by IS 543 on 10/10/24.
//

import SwiftUI

let topics = [
    "Basic Greetings and Farewells",
    "Common Phrases",
    "Numbers (1-10)",
    "Colors",
    "Family Members",
    "Food and Drink",
    "Common Adjetives",
    "Days of the Week",
    "Weather Vocabulary"
]

struct ContentView: View {
    
    @Bindable var spanishViewModel: SpanishViewModel
    
    var body: some View {
        NavigationStack {
            List(topics, id: \.self) { topic in
                TopicCell(topic: topic)
            }
            .listStyle(.plain)
            .navigationTitle("Learn Spanish")
        }
    }
}
    
struct TopicCell: View{
    let topic: String
    
    var body: some View {
        HStack{
            NavigationLink{
                TopicLessonView(topic: topic)
            }label: {
                Text(topic)
            }
        }
    }
}

struct TopicLessonView: View {
    let topic: String
    
    var body: some View {
        VStack {
            Text("Lesson about topic: \(topic)")
            NavigationLink {
                QuizScreen(topic: topic)
            } label: {
                Text("Take the Quiz")
            }
            NavigationLink{
                FlashcardsScreen(topic: topic)
            } label: {
                Text("Flashcards")
            }
        }
        .navigationTitle("\(topic)")
    }
}


struct FlashcardsScreen: View {
    let topic: String // Receive the topic
    
    var body: some View {
        TabView {
            if let words = vocabulary[topic] { // Check if the topic exists in the vocabulary
                ForEach(words, id: \.self) { word in
                    VStack {
                        Text(word) // Display each word
                            .font(.system(size: 24))
                            .padding()
                    }
                    .background(Color(.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 5)
                    .padding()
                }
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .navigationTitle("\(topic) Flashcards") // Set navigation title to the topic
    }
}


let vocabulary: [String: [String]] = [
    "Basic Greetings and Farewells": [
        "Hola (Hello)",
        "Adiós (Goodbye)",
        "Buenos días (Good morning)",
        "Buenas tardes (Good afternoon)",
        "Buenas noches (Good night)",
        "¿Cómo estás? (How are you?)",
        "Estoy bien (I am fine)",
        "Hasta luego (See you later)"
    ],
    "Common Phrases": [
        "Por favor (Please)",
        "Gracias (Thank you)",
        "De nada (You're welcome)",
        "Lo siento (I'm sorry)",
        "¿Cuánto cuesta? (How much does it cost?)",
        "¿Dónde está...? (Where is...?)",
        "Me gustaría (I would like)"
    ],
    "Numbers (1-10)": [
        "Uno (1)", "Dos (2)", "Tres (3)", "Cuatro (4)", "Cinco (5)",
        "Seis (6)", "Siete (7)", "Ocho (8)", "Nueve (9)", "Diez (10)"
    ],
    "Colors": [
        "Rojo (Red)", "Azul (Blue)", "Verde (Green)", "Amarillo (Yellow)",
        "Negro (Black)", "Blanco (White)", "Naranja (Orange)", "Rosa (Pink)"
    ],
    "Family Members": [
        "Madre (Mother)", "Padre (Father)", "Hermano (Brother)", "Hermana (Sister)",
        "Abuelo (Grandfather)", "Abuela (Grandmother)", "Tío (Uncle)", "Tía (Aunt)"
    ],
    "Food and Drink": [
        "Agua (Water)", "Comida (Food)", "Pan (Bread)", "Fruta (Fruit)",
        "Carne (Meat)", "Verdura (Vegetable)", "Café (Coffee)", "Té (Tea)"
    ],
    "Common Adjectives": [
        "Grande (Big)", "Pequeño (Small)", "Bonito (Beautiful)", "Feo (Ugly)",
        "Feliz (Happy)", "Triste (Sad)", "Interesante (Interesting)", "Aburrido (Boring)"
    ],
    "Days of the Week": [
        "Lunes (Monday)", "Martes (Tuesday)", "Miércoles (Wednesday)",
        "Jueves (Thursday)", "Viernes (Friday)", "Sábado (Saturday)", "Domingo (Sunday)"
    ],
    "Weather Vocabulary": [
        "Hace sol (It's sunny)", "Hace frío (It's cold)", "Está nublado (It's cloudy)",
        "Llueve (It's raining)", "Nieva (It's snowing)", "Hace calor (It's hot)"
    ],
    "Common Verbs": [
        "Ser (To be)", "Estar (To be)", "Tener (To have)", "Hacer (To do/make)",
        "Ir (To go)", "Comer (To eat)", "Beber (To drink)", "Hablar (To speak)"
    ]
]

#Preview {
    ContentView(spanishViewModel:   SpanishViewModel())
}
