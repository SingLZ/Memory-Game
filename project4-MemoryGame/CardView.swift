//
//  CardView.swift
//  project4-MemoryGame
//
//  Created by Lixing Zheng on 3/22/24.
//

import SwiftUI

struct CardView: View {
    @State var card: Card
    @State private var isShowEmoji = false
    var onTap: () -> Void

    
    var body: some View {
        if !card.isMatched{
            ZStack {
                RoundedRectangle(cornerRadius: 10.0)
                    .fill(isShowEmoji ? .white : .blue)
                    .shadow(color: .black, radius: 4, x: -2, y:2)
            
                Text(isShowEmoji ? card.emoji : "")
                        .font(.system(size: 30))
                        .foregroundStyle(.white)
                        .padding()
                }
    

                .onTapGesture {
                    isShowEmoji.toggle()
                    card.isFaceUp.toggle()
                    onTap()
                    print("pass")
                }
                .frame(width: 90, height: 150)
        } else {
            Color.clear
        }
    }
}

#Preview {
    CardView(card: Card(emoji: "🌍"), onTap: {})



}


// Card data model
struct Card : Equatable {
    let emoji: String
    var isFaceUp: Bool = false
    var isMatched: Bool = false
    
    static var mockedCards = [
        Card(emoji: "🏝️"),
        Card(emoji: "🏝️"),
        Card(emoji: "🌍"),
        Card(emoji: "🌍"),
        Card(emoji: "💅"),
        Card(emoji: "💅"),
        Card(emoji: "🍇"),
        Card(emoji: "🍇"),
        Card(emoji: "🎈"),
        Card(emoji: "🎈"),
        Card(emoji: "😂"),
        Card(emoji: "😂"),
        Card(emoji: "😃"),
        Card(emoji: "😃"),
        Card(emoji: "🤩"),
        Card(emoji: "🤩")
        
    ]
    
    static func == (lhs: Card, rhs: Card) -> Bool {
            // Customize the equality check based on your requirements
            return lhs.emoji == rhs.emoji
        }
}
