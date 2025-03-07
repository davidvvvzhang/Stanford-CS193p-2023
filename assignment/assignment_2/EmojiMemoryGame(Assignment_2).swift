//
//  EmojiMemoryGame(Assignment_2).swift
//  Memorize
//
//  Created by David on 2025/2/28.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static let themes: [Theme] = [
        Theme(name: "Halloween", emojis: ["👻", "🎃", "🕷️", "🕸️", "💀", "🧙‍♀️"], numberOfPairs: 6, color: .orange),
        Theme(name: "Animals", emojis: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊"], numberOfPairs: 6, color: .green),
        Theme(name: "Food", emojis: ["🍎", "🍕", "🍔", "🍟", "🍩", "🍦"], numberOfPairs: 6, color: .red),
        Theme(name: "Sports", emojis: ["⚽️", "🏀", "🏈", "🎾", "🏐", "🏓"], numberOfPairs: 6, color: .blue),
        Theme(name: "Vehicles", emojis: ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎️"], numberOfPairs: 6, color: .purple),
        Theme(name: "Flags", emojis: ["🇨🇳", "🇺🇸", "🇬🇧", "🇯🇵", "🇫🇷", "🇩🇪"], numberOfPairs: 6, color: .yellow)
    ]
    
    @Published private var currentTheme: Theme
    
    @Published private var model: MemoryGame<String>
    
    init() {
        let selectedTheme = EmojiMemoryGame.themes.randomElement()!
        self.currentTheme = selectedTheme
        self.model = EmojiMemoryGame.createMemoryGame(theme: selectedTheme)
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var themeName: String {
        return currentTheme.name
    }
    
    var themeColor: Color {
        return currentTheme.color
    }
    
    var score: Int {
        return model.score
    }
    
    private static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: theme.numberOfPairs) { pairIndex in
            if theme.emojis.indices.contains(pairIndex) {
                return theme.emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
        objectWillChange.send()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func newGame() {
        let newTheme = EmojiMemoryGame.themes.randomElement()!
        currentTheme = newTheme
        model = EmojiMemoryGame.createMemoryGame(theme: newTheme)
        objectWillChange.send()
    }
    
    
    
    struct Theme: Identifiable {
        let id = UUID()
        let name: String
        let emojis: [String]
        let numberOfPairs: Int
        let color: Color
        
        init(name: String, emojis: [String], numberOfPairs: Int, color: Color) {
            self.name = name
            self.emojis = emojis
            self.numberOfPairs = numberOfPairs
            self.color = color
        }
    }
}
