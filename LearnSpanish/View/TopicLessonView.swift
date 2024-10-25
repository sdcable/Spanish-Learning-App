//
//  TopicLessonView.swift
//  LearnSpanish
//
//  Created by IS 543 on 10/25/24.
//

import SwiftUI

struct TopicLessonView: View {
    let topic: String
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State private var flashcardsCompleted: Bool = false
    @State private var quizCompleted: Bool = false
    var spanishViewModel: SpanishViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                Text("\(spanishViewModel.getSpanishLesson(for: topic) ?? "No Lesson")")
                    .padding()
                
                if let vocabList = spanishViewModel.getVocabList(for: topic){
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
