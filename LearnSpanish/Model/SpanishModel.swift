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
    
    let topics = [
        "Basic Greetings and Farewells",
        "Common Phrases",
        "Numbers (1-10)",
        "Colors",
        "Family Members",
        "Food and Drink",
        "Common Adjectives",
        "Days of the Week",
        "Weather Vocabulary"
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

}


