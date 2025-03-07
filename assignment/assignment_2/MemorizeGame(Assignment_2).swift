//
//  MemorizeGame(Assignment_2).swift
//  Memorize
//
//  Created by David on 2025/2/28.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var score: Int = 0
    
    private var seenCards: Set<String> = []
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        // add numberOfPairsOfCards x 2 cards
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
        cards.shuffle()
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        score += 2
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    } else {
                        if seenCards.contains(cards[chosenIndex].id) || seenCards.contains(cards[potentialMatchIndex].id) {
                            score -= 1
                        }
                        seenCards.insert(cards[chosenIndex].id)
                        seenCards.insert(cards[potentialMatchIndex].id)
                    }
                    cards[chosenIndex].isFaceUp = true
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
            }
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
    mutating func newGame() {
        score = 0
        cards.shuffle()
        for index in cards.indices {
            if cards[index].isFaceUp || cards[index].isMatched {
                cards[index].isFaceUp = false
                cards[index].isMatched = false
            }
        }
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {

        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        
        var id: String
        var debugDescription: String {
            return "\(id): \(content) \(isFaceUp ? "up" : "down")\(isMatched ? "matched" : "")"
        }
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
