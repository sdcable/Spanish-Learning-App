//
//  HomePageView.swift
//  LearnSpanish
//
//  Created by IS 543 on 10/10/24.
//

import SwiftUI

struct HomePageView: View {
    var spanishViewModel: SpanishViewModel
    
    var body: some View {
        NavigationStack {
            List(spanishViewModel.getTopics(), id: \.self) { topic in
                TopicCell(topic: topic, spanishViewModel: spanishViewModel)
            }
            .listStyle(.plain)
            .background(Color("OffWhite"))
            .navigationTitle("Learn Spanish")
        }
        .background(Color("OffWhite"))
        .edgesIgnoringSafeArea(.all)
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
            isCompleted = spanishViewModel.loadCompletionState(for: topic)  // Load the state
        }
        
    }
}

#Preview {
    HomePageView(spanishViewModel:   SpanishViewModel())
}
