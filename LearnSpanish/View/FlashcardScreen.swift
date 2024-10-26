//
//  FlashcardScreen.swift
//  LearnSpanish
//
//  Created by IS 543 on 10/25/24.
//

import SwiftUI

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
            if !shuffledVocabList.isEmpty { //This is to allow shuffling each time
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
        if let vocabList = spanishViewModel.getVocabList(for: topic) {
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
