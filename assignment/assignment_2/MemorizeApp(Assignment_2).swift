//
//  MemorizeApp(Assignment_2).swift
//  Memorize
//
//  Created by David on 2025/1/28.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
