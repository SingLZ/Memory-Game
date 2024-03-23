//
//  ContentView.swift
//  project4-MemoryGame
//
//  Created by Lixing Zheng on 3/22/24.
//

import SwiftUI

struct ContentView: View {
    @State private var cards: [Card] = Card.mockedCards
    @State var refreshView = false
    @State private var selectedCards: [Card] = []
    @State private var gridSize: Int = 3 // Default grid size
    
    var body: some View {
        ScrollView(.vertical){
            HStack(spacing: 50){
                Button("Choose Size", action: {
                    switch gridSize {
                    case 2: gridSize = 3
                    case 3: gridSize = 6
                    default: gridSize = 3;
                    }
                })
                Button("Reset", action: {
                    resetGame()
                })
                Button("Reveal Sets", action: {
                    resetGame()
                })
            }
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 30) {
                ForEach(cards.indices, id: \.self) { index in
                    LazyHGrid(rows: [GridItem(.flexible())], spacing: 30){
                        CardView(card: cards[index], onTap: { handleCardTap(cards[index]) })



                    }
                }
            }
        }
            .padding()
}
    
    
    private func refresh() {
            refreshView.toggle()
        }

    
    private func handleCardTap(_ card: Card) {
        selectedCards.append(card)
        print(selectedCards.count)
        if selectedCards.count == 2 {
            checkForMatch()
        }
    }

    private func resetGame() {
           cards = Card.mockedCards
           selectedCards = []
       }

    private func checkForMatch() {
        print("why")
        if selectedCards.count == 2 {
            // Check if the selected cards match
            if selectedCards[0].emoji == selectedCards[1].emoji {
                    print("Match found!")
                    // Update the isMatched attribute of the matched cards in the original cards array
                for index in cards.indices {
                            if selectedCards.contains(cards[index]) {
                                // Change the appearance of matched cards
                                cards[index].isMatched = true
                            }
                        }
                               cards.removeAll(where: { $0 == selectedCards[0] })
                               selectedCards.removeAll()
                refresh()
            } else {
                    print("No match found.")
                    // If the cards don't match, flip them face-down after a short delay
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        for index in cards.indices {
                            if selectedCards.contains(cards[index]) {
                                cards[index].isFaceUp = false
                            }
                        }
                        for card in cards {
                                print("Emoji: \(card.emoji), isFaceUp: \(card.isFaceUp), isMatched: \(card.isMatched)")
                            }
                    }
                }
                
                // Clear selected cards array
            selectedCards.removeAll()
            }
        refresh()
        }


}

#Preview {
    ContentView()
}
