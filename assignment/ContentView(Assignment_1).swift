//
//  ContentView(Assignment_1).swift
//  Memorize
//
//  Created by David on 2025/1/28.
//

import SwiftUI

struct ContentView: View {
    @State var emojis: [String] = []
    
    @State var cardCount: Int = 12
    
    var body: some View {
        VStack{
            Text("Memorize!").font(.largeTitle)
            ScrollView {
                cards
            }
            Spacer()
            cardAdjusters
        }
        .padding()
        .onAppear() {
            emojis = Halloween_emojis
            emojis.append(contentsOf: emojis)
            emojis.shuffle()
        }
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
            ForEach(0..<min(cardCount, emojis.count), id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    var cardAdjusters: some View {
        HStack(alignment: .center, spacing: 40){
            Halloween_Button
            Vehicle_Button
            Sport_Button
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    /*
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount = min(max(cardCount + offset, 1), emojis.count)
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    var cardRemover: some View {
        return cardCountAdjuster(by: -1, symbol: "pencil.tip.crop.circle.badge.minus")
    }
    
    var cardAdder: some View {
        return cardCountAdjuster(by: 1, symbol: "pencil.tip.crop.circle.badge.plus")
    }
    */
    
    var cardThemeAdjusters: some View {
        HStack{
            Halloween_Button
            Spacer()
            Vehicle_Button
            Spacer()
            Sport_Button
        }
    }
    
    func cardThemeAdjuster(by name: [String], symbol: String) -> some View {
        Button(action: {
            emojis = name
            emojis.append(contentsOf: emojis) // double sum of cards
            emojis.shuffle() // shuffle the cards
        }, label: {
            Image(systemName: symbol)
        })
    }
    
    var Halloween_Button: some View {
        return cardThemeAdjuster(by: Halloween_emojis, symbol: "sunglasses")
    }
    
    var Vehicle_Button: some View {
        return cardThemeAdjuster(by:Vehicle_emojis, symbol: "car.fill")
    }
    
    var Sport_Button: some View {
        return cardThemeAdjuster(by: Sport_emojis, symbol: "figure.cooldown")
    }
    
    let Halloween_emojis = ["👻","👽","☠️","😈","👾","🎃"]
    
    let Vehicle_emojis = ["🚗","🛻","🚐","🚑","🚎","🏎️"]
    
    let Sport_emojis = ["⚽️","🏀","🏈","⚾️","🏐","🎱"]
}

struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = false
    
    var body: some View {
        ZStack {
            let base: RoundedRectangle = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}









#Preview {
    ContentView()
}
