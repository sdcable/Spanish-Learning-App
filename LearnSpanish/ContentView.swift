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
                QuizScreen()
            } label: {
                Text("Take the Quiz")
            }
        }
        .navigationTitle("\(topic)")s
    }
}

struct QuizScreen: View {
    var body: some View{
        VStack {
            Form{
                Section{
                    Text("Question N goes here.")
                }
                Section{
                    Text("A")
                    Text("B")
                    Text("C")
                }
            }
            Text("Quiz Form Goes Here so please work")
        }
    }
}

#Preview {
    ContentView()
}
