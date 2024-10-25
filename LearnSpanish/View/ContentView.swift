//
//  ContentView.swift
//  LearnSpanish
//
//  Created by IS 543 on 10/10/24.
//

import SwiftUI

struct ContentView: View {
    var spanishViewModel: SpanishViewModel
    
    var body: some View {
        NavigationStack {
            List(spanishViewModel.topics, id: \.self) { topic in
                TopicCell(topic: topic, spanishViewModel: spanishViewModel)
            }
            .listStyle(.plain)
            .navigationTitle("Learn Spanish")
        }
    }
}

struct TopicCell: View {
    let topic: String
    @State private var isCompleted: Bool = false
    var spanishViewModel: SpanishViewModel  // Add ViewModel as a property
    
    var body: some View {
        HStack {
                // Button to toggle completion status
                Button(action: {
                    isCompleted.toggle()  // Toggle the state
                    spanishViewModel.saveCompletionState(for: topic, isCompleted: isCompleted)  // Save using ViewModel
                }) {
                    Image(systemName: isCompleted ? "checkmark.square.fill" : "square")
                        .foregroundColor(isCompleted ? .green : .gray)
                }
                
                .buttonStyle(PlainButtonStyle())  // Make the button look like a simple image toggle
            NavigationLink {
                TopicLessonView(topic: topic, spanishViewModel: spanishViewModel)
            } label: {
                Text(topic)
                Spacer()
            }
            
        }
        .padding(.vertical, 8)
        .onAppear {
            isCompleted = spanishViewModel.loadCompletionState(for: topic)  // Load the state using ViewModel
        }
    }
}

struct TopicLessonView: View {
    let topic: String
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State private var flashcardsCompleted: Bool = false
    @State private var quizCompleted: Bool = false
    var spanishViewModel: SpanishViewModel  // Add ViewModel to manage state
    
    var body: some View {
        VStack {
            ScrollView {
                Text("\(spanishLessons[topic] ?? "No information available")")
                    .padding()
                
                if let vocabList = vocabulary[topic] {
                    VStack(alignment: .leading) {
                        Text("Vocabulary:")
                            .font(.headline)
                            .padding(.bottom, 5)
                        
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(vocabList, id: \.self) { vocab in
                                if let spanish = vocab["Spanish"], let english = vocab["English"] {
                                    VStack(alignment: .leading) {
                                        Text(spanish)
                                            .font(.title3)
                                            .bold()
                                        Text(english)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity, minHeight: 100, alignment: .leading)
                                    .background(Color.blue.opacity(0.1))
                                    .cornerRadius(5)
                                    .border(Color.black, width: 1)
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
            .padding()
            
            Spacer()
            
            VStack {
                HStack(spacing: 40) {
                    VStack {
                        NavigationLink {
                            FlashcardsScreen(topic: topic, spanishViewModel: spanishViewModel)
                        } label: {
                            Text("Flashcards")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(10)
                        }
                        
                        // Flashcards checkbox
                        HStack {
                            Text("Completed?")
                            Button(action: {
                                flashcardsCompleted.toggle()
                                spanishViewModel.saveCompletionState(for: "\(topic)_flashcards", isCompleted: flashcardsCompleted)
                            }) {
                                Image(systemName: flashcardsCompleted ? "checkmark.square.fill" : "square")
                                    .foregroundColor(flashcardsCompleted ? .green : .gray)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    
                    VStack {
                        NavigationLink {
                            QuizScreen(topic: topic, spanishViewModel: spanishViewModel)
                        } label: {
                            Text("Take the Quiz")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        
                        // Quiz checkbox
                        HStack {
                            Text("Completed 5/5?")
                            Button(action: {
                                quizCompleted.toggle()
                                spanishViewModel.saveCompletionState(for: "\(topic)_quiz", isCompleted: quizCompleted)
                            }) {
                                Image(systemName: quizCompleted ? "checkmark.square.fill" : "square")
                                    .foregroundColor(quizCompleted ? .green : .gray)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }
            .padding(.top, 20)
        }
        .navigationTitle("\(topic)")
        .onAppear {
            // Load the saved states from UserDefaults
            flashcardsCompleted = spanishViewModel.loadCompletionState(for: "\(topic)_flashcards")
            quizCompleted = spanishViewModel.loadCompletionState(for: "\(topic)_quiz")
        }
    }
}





struct FlashcardsScreen: View {
    let topic: String
    var spanishViewModel: SpanishViewModel
    @State private var currentIndex = 0
    @State private var isFaceUp = true
    @State private var shuffledVocabList: [[String: String]] = []
    @State private var offset: CGFloat = 0
    @State private var moveToNextCard = false

    var body: some View {
        let language = isFaceUp ? "Spanish" : "English"
        Text("\(language)")
            .foregroundColor(.green)
            .font(.largeTitle)

        VStack {
            if !shuffledVocabList.isEmpty {
                VStack {
                    ZStack {
                        if let spanish = shuffledVocabList[currentIndex]["Spanish"], let english = shuffledVocabList[currentIndex]["English"] {
                            Text(isFaceUp ? spanish : english)
                                .font(.title)
                                .padding()
                                .cardify(isFaceUp: isFaceUp)
                                .offset(x: offset)  // Apply the sliding effect
                        }
                    }
                    .onTapGesture {
                        withAnimation(.linear(duration: 0.3)) {
                            isFaceUp.toggle()
                        }
                    }
                    .frame(maxWidth: 300, maxHeight: 200)
                    .padding()

                    HStack {
                        Button(action: previousCard) {
                            Text("Previous")
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)

                        Button(action: nextCard) {
                            Text("Next")
                        }
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }
            } else {
                Text("No vocabulary available for this topic.")
            }
        }
        .navigationTitle("Flashcards: \(topic)")
        .onAppear() {
            shuffleVocab()
            spanishViewModel.saveCompletionState(for: "\(topic)_flashcards", isCompleted: true)
        }
    }
    
    // MARK: - Actions

    func shuffleVocab() {
        if let vocabList = vocabulary[topic] {
            shuffledVocabList = vocabList.shuffled()
        }
    }

    func nextCard() {
        withAnimation(.easeInOut(duration: 0.2)) {
            offset = -UIScreen.main.bounds.width  // Move current card off-screen to the left
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            // After the animation completes, update the current index and reset offset
            currentIndex = (currentIndex + 1) % shuffledVocabList.count
            offset = UIScreen.main.bounds.width  // Move new card off-screen to the right
            
            withAnimation(.easeInOut(duration: 0.2)) {
                offset = 0  // Bring new card to the center
            }
        }
    }

    func previousCard() {
        withAnimation(.easeInOut(duration: 0.5)) {
            offset = UIScreen.main.bounds.width  // Move current card off-screen to the right
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // After the animation completes, update the current index and reset offset
            currentIndex = (currentIndex - 1 + shuffledVocabList.count) % shuffledVocabList.count
            offset = -UIScreen.main.bounds.width  // Move new card off-screen to the left
            
            withAnimation(.easeInOut(duration: 0.5)) {
                offset = 0  // Bring new card to the center
            }
        }
    }
}



let vocabulary: [String: [[String: String]]] = [
    "Basic Greetings and Farewells": [
        ["Spanish": "Hola", "English": "Hello"],
        ["Spanish": "Adiós", "English": "Goodbye"],
        ["Spanish": "Buenos días", "English": "Good morning"],
        ["Spanish": "Buenas tardes", "English": "Good afternoon"],
        ["Spanish": "Buenas noches", "English": "Good night"],
        ["Spanish": "¿Cómo estás?", "English": "How are you?"],
        ["Spanish": "Estoy bien", "English": "I am fine"],
        ["Spanish": "Hasta luego", "English": "See you later"]
    ],
    "Common Phrases": [
        ["Spanish": "Por favor", "English": "Please"],
        ["Spanish": "Gracias", "English": "Thank you"],
        ["Spanish": "De nada", "English": "You're welcome"],
        ["Spanish": "Lo siento", "English": "I'm sorry"],
        ["Spanish": "¿Cuánto cuesta?", "English": "How much does it cost?"],
        ["Spanish": "¿Dónde está...?", "English": "Where is...?"],
        ["Spanish": "Me gustaría", "English": "I would like"]
    ],
    "Numbers (1-10)": [
        ["Spanish": "Uno", "English": "1"],
        ["Spanish": "Dos", "English": "2"],
        ["Spanish": "Tres", "English": "3"],
        ["Spanish": "Cuatro", "English": "4"],
        ["Spanish": "Cinco", "English": "5"],
        ["Spanish": "Seis", "English": "6"],
        ["Spanish": "Siete", "English": "7"],
        ["Spanish": "Ocho", "English": "8"],
        ["Spanish": "Nueve", "English": "9"],
        ["Spanish": "Diez", "English": "10"]
    ],
    "Colors": [
        ["Spanish": "Rojo", "English": "Red"],
        ["Spanish": "Azul", "English": "Blue"],
        ["Spanish": "Verde", "English": "Green"],
        ["Spanish": "Amarillo", "English": "Yellow"],
        ["Spanish": "Negro", "English": "Black"],
        ["Spanish": "Blanco", "English": "White"],
        ["Spanish": "Naranja", "English": "Orange"],
        ["Spanish": "Rosa", "English": "Pink"]
    ],
    "Family Members": [
        ["Spanish": "Madre", "English": "Mother"],
        ["Spanish": "Padre", "English": "Father"],
        ["Spanish": "Hermano", "English": "Brother"],
        ["Spanish": "Hermana", "English": "Sister"],
        ["Spanish": "Abuelo", "English": "Grandfather"],
        ["Spanish": "Abuela", "English": "Grandmother"],
        ["Spanish": "Tío", "English": "Uncle"],
        ["Spanish": "Tía", "English": "Aunt"]
    ],
    "Food and Drink": [
        ["Spanish": "Agua", "English": "Water"],
        ["Spanish": "Comida", "English": "Food"],
        ["Spanish": "Pan", "English": "Bread"],
        ["Spanish": "Fruta", "English": "Fruit"],
        ["Spanish": "Carne", "English": "Meat"],
        ["Spanish": "Verdura", "English": "Vegetable"],
        ["Spanish": "Café", "English": "Coffee"],
        ["Spanish": "Té", "English": "Tea"]
    ],
    "Common Adjectives": [
        ["Spanish": "Grande", "English": "Big"],
        ["Spanish": "Pequeño", "English": "Small"],
        ["Spanish": "Bonito", "English": "Beautiful"],
        ["Spanish": "Feo", "English": "Ugly"],
        ["Spanish": "Feliz", "English": "Happy"],
        ["Spanish": "Triste", "English": "Sad"],
        ["Spanish": "Interesante", "English": "Interesting"],
        ["Spanish": "Aburrido", "English": "Boring"]
    ],
    "Days of the Week": [
        ["Spanish": "Lunes", "English": "Monday"],
        ["Spanish": "Martes", "English": "Tuesday"],
        ["Spanish": "Miércoles", "English": "Wednesday"],
        ["Spanish": "Jueves", "English": "Thursday"],
        ["Spanish": "Viernes", "English": "Friday"],
        ["Spanish": "Sábado", "English": "Saturday"],
        ["Spanish": "Domingo", "English": "Sunday"]
    ],
    "Weather Vocabulary": [
        ["Spanish": "Hace sol", "English": "It's sunny"],
        ["Spanish": "Hace frío", "English": "It's cold"],
        ["Spanish": "Está nublado", "English": "It's cloudy"],
        ["Spanish": "Llueve", "English": "It's raining"],
        ["Spanish": "Nieva", "English": "It's snowing"],
        ["Spanish": "Hace calor", "English": "It's hot"]
    ],
    "Common Verbs": [
        ["Spanish": "Ser", "English": "To be"],
        ["Spanish": "Estar", "English": "To be"],
        ["Spanish": "Tener", "English": "To have"],
        ["Spanish": "Hacer", "English": "To do/make"],
        ["Spanish": "Ir", "English": "To go"],
        ["Spanish": "Comer", "English": "To eat"],
        ["Spanish": "Beber", "English": "To drink"],
        ["Spanish": "Hablar", "English": "To speak"]
    ]
]


let spanishLessons: [String: String] = [
    "Basic Greetings and Farewells": """
    Learning greetings and farewells in Spanish is the first step to starting a conversation! 
    'Hola' is the most common way to say 'Hello,' but there are other ways to greet someone depending on the time of day. 
    
    In the morning, you can say 'Buenos días' ('Good morning'), and in the afternoon or evening, 'Buenas tardes' ('Good afternoon') or 'Buenas noches' ('Good night'). 
    
    To ask how someone is, you can say '¿Cómo estás?' for informal situations or '¿Cómo está usted?' for formal ones. 
    
    Respond with 'Estoy bien' ('I’m good'), or 'Estoy cansado/a' ('I’m tired').
    
    To say goodbye, 'Adiós' is the most common way to say 'Goodbye,' but you can also say 'Hasta luego' ('See you later'), 'Hasta mañana' ('See you tomorrow'), or 'Nos vemos' ('We’ll see each other').
    
    Practice these phrases to greet others and end conversations politely!
    """,
    
    "Common Phrases": """
    Knowing common phrases will help you navigate basic conversations. 
    
    Start with 'Por favor' ('Please') and 'Gracias' ('Thank you'), two essential polite phrases. 
    
    If someone thanks you, respond with 'De nada' ('You're welcome'). 
    
    Asking for help is easy with '¿Me puedes ayudar?' ('Can you help me?'), and if you're looking for something, say '¿Dónde está…?' followed by the place or object you're seeking. 
    
    For example, '¿Dónde está el baño?' means 'Where is the bathroom?'. 
    
    You can introduce yourself with 'Me llamo...' ('My name is...') and ask others, '¿Cómo te llamas?' ('What's your name?'). 
    
    Other useful phrases include 'Lo siento' ('I’m sorry'), 'No entiendo' ('I don’t understand'), and '¿Cuánto cuesta?' ('How much does it cost?').
    
    Learning these everyday expressions will make communication smoother in Spanish-speaking environments!
    """,
    
    "Numbers (1-10)": """
    Learning numbers is crucial for basic communication. Let's focus on numbers 1-10! 
    
    'Uno' is 1, 'dos' is 2, 'tres' is 3, 'cuatro' is 4, 'cinco' is 5, 'seis' is 6, 'siete' is 7, 'ocho' is 8, 'nueve' is 9, and 'diez' is 10. 
    
    Practice counting aloud to become familiar with the pronunciation. 
    
    Numbers are important in everyday situations like ordering food or drinks, buying items, or asking for directions. 
    
    For example, if you want two coffees, you can say 'Dos cafés, por favor.' 
    
    To ask someone's age, use '¿Cuántos años tienes?' ('How old are you?'), and if you're responding, you can say 'Tengo [number] años' ('I am [number] years old'). 
    
    You can also use numbers to talk about time, such as 'Son las tres' ('It's three o'clock'). 
    
    Get comfortable with these numbers, as they’ll come in handy in many scenarios!
    """,
    
    "Colors": """
    Colors are a fun and useful part of language learning! Here are the names of common colors in Spanish: 
    
    'Rojo' is red, 'azul' is blue, 'verde' is green, 'amarillo' is yellow, 'negro' is black, 'blanco' is white, 'morado' is purple, 'rosado' is pink, 'naranja' is orange, and 'gris' is gray. 
    
    You can use these color words to describe objects around you. For example, 'La manzana es roja' means 'The apple is red,' and 'El cielo es azul' means 'The sky is blue.' 
    If you want to ask about the color of something, you can say '¿De qué color es?' 
    You might also come across variations like 'verde oscuro' (dark green) or 'azul claro' (light blue). 
    
    Learning colors is helpful when shopping for clothes or describing things in conversations. 
    
    Try identifying the colors of objects around you in Spanish to reinforce your vocabulary!
    """,
    
    "Family Members": """
    Talking about family in Spanish is important, as family connections play a central role in many Spanish-speaking cultures. 
    
    Common family vocabulary includes 'madre' for 'mother,' 'padre' for 'father,' 'hermano' for 'brother,' and 'hermana' for 'sister.' 
    
    Grandparents are 'abuelo' and 'abuela,' while aunts and uncles are 'tía' and 'tío.' 
    
    If you have children, you’ll refer to them as 'hijo' (son) or 'hija' (daughter). 
    
    Cousins are 'primo' (male cousin) and 'prima' (female cousin). 
    
    To talk about your family, you can say 'Tengo una hermana' ('I have a sister') or 'Mi madre se llama...' ('My mother’s name is...'). 
    
    If you want to ask someone about their family, say '¿Tienes hermanos?' ('Do you have siblings?'). 
    
    Knowing how to talk about family members helps in personal conversations and allows you to connect more with people in Spanish-speaking cultures.
    """,
    
    "Food and Drink": """
    Food is a big part of any culture, and learning some basic Spanish words for food and drink can help you navigate menus and conversations. 
    
    'Comida' means food, and 'bebida' is drink. 
    
    Common food items include 'pan' (bread), 'manzana' (apple), 'carne' (meat), 'pollo' (chicken), 'arroz' (rice), and 'verduras' (vegetables). 
    
    Drinks include 'agua' (water), 'jugo' (juice), 'café' (coffee), and 'té' (tea). 
    
    If you’re ordering in a restaurant, you can say 'Quiero...' followed by the food item. For example, 'Quiero una ensalada' means 'I want a salad.' 
    
    To ask for the check, say 'La cuenta, por favor.' 
    
    If you have a dietary restriction, you can say 'No como...' followed by the food, like 'No como carne' ('I don’t eat meat').
    
    Learning food and drink vocabulary helps you enjoy meals and communicate your preferences when dining out!
    """,
    
    "Common Adjectives": """
    Adjectives help describe things and make your Spanish more expressive! 
    
    Some of the most common adjectives include 'grande' (big), 'pequeño' (small), 'bueno' (good), 'malo' (bad), 'rápido' (fast), 'lento' (slow), 'nuevo' (new), and 'viejo' (old). 
    
    You’ll use these adjectives to describe objects, people, or situations. 
    
    For example, 'El coche es grande' means 'The car is big,' and 'El libro es nuevo' means 'The book is new.' 
    
    Adjectives in Spanish change to agree with the gender and number of the noun they describe. For instance, 'La casa es grande' (The house is big) vs. 'Las casas son grandes' (The houses are big). 
    
    Some other useful adjectives include 'bonito' (pretty), 'feo' (ugly), 'caliente' (hot), and 'frío' (cold). 
    
    Practice describing things around you using these adjectives!
    """,
    
    "Days of the Week": """
    Knowing the days of the week is essential for talking about your schedule! 
    
    In Spanish, the days of the week are: 'lunes' (Monday), 'martes' (Tuesday), 'miércoles' (Wednesday), 'jueves' (Thursday), 'viernes' (Friday), 'sábado' (Saturday), and 'domingo' (Sunday).
    
    To ask what day it is, say '¿Qué día es hoy?' ('What day is it today?'), and to answer, you can say 'Hoy es...' followed by the day. 
    
    The days of the week in Spanish do not start with a capital letter unless they are at the beginning of a sentence. 
    
    You can also talk about what you do on certain days using 'el' for singular and 'los' for plural. 
    
    For example, 'Voy al gimnasio los lunes' means 'I go to the gym on Mondays.' 
    
    Practice saying the days of the week and using them in conversation to talk about your plans and routine!
    """,
    
    "Weather Vocabulary": """
    Talking about the weather is a great way to start a conversation! 
    
    Some common weather phrases in Spanish include 'Hace sol' ('It’s sunny'), 'Hace frío' ('It’s cold'), 'Hace calor' ('It’s hot'), and 'Está lloviendo' ('It’s raining'). 
    
    If it’s snowing, you can say 'Está nevando,' and if it’s cloudy, say 'Está nublado.' 
    
    To ask about the weather, use '¿Qué tiempo hace?' ('What’s the weather like?'). 
    
    You can also describe the temperature with phrases like 'Hace mucho calor' ('It’s very hot') or 'Hace mucho frío' ('It’s very cold'). 
    
    Weather can vary a lot depending on the region, so learning how to talk about different weather conditions will help you wherever you go!
    """
]


#Preview {
    ContentView(spanishViewModel:   SpanishViewModel())
}
