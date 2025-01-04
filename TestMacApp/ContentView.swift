//
//  ContentView.swift
//  TestMacApp
//
//  Created by Silhouette Of on 2025/1/4.
//

import SwiftUI

struct ContentView: View {
    let emojis: [String] = ["😃", "🤪","😎", "😗", "😹", "😼", "😽"]
    @State var cardCount: Int = 4
    var body: some View {
        VStack{
            ScrollView{
                cards
            }
            Spacer()
            cardsCountAdjusters
            
        }
        .padding()
    }
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
            print(cardCount)
        
        }, label: {
            Image(systemName: symbol)
        })
        .imageScale(.large)
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    var cardsCountAdjusters: some View {
        HStack{
            cardRemover
            Spacer()
            cardAdder
        }
    }
    var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120, maximum: 200))]){
            ForEach(0..<cardCount, id: \.self){ index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        
    }
    var cardAdder: some View {
        cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
    }
}


struct CardView: View {
    let content: String
    @State var showCard: Bool = false
    var body: some View {
        ZStack {
            let cardBase = RoundedRectangle(cornerSize: .init(width: 10, height: 10))
            Group {
                cardBase.fill(Color.red)
                cardBase.strokeBorder(lineWidth: 2, antialiased: true)
                Text(content).font(.largeTitle)
            }
            .opacity(showCard ? 1 : 0)
            
            cardBase.fill(Color.blue).opacity(showCard ? 0 : 0.5)
            
        }
        .onTapGesture {
            showCard.toggle()
        }
    }
}













#Preview {
    ContentView()
}
