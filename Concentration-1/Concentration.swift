//
//  Concentration.swift
//  Concentration-1
//
//  Created by Alexander Konovalov on 11.12.2020.
//

import Foundation

struct Concentration
{
  private(set) var cards = [Card]()
  
  private var indexOfOneAndOnlyFaceUpCard: Int? {
    get {
      return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
//      var foundIndex: Int?
//      for index in cards.indices {
//        if cards[index].isFaceUp {
//          if foundIndex == nil {
//            foundIndex = index
//          } else {
//            return nil
//          }
//        }
//      }
//      return foundIndex
    }
    set {
      for index in cards.indices {
        cards[index].isFaceUp = (index == newValue)
      }
    }
  }
  
  mutating func chooseCard(at index: Int) {
    assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index is not in the cards")
    if !cards[index].isMatched {
      if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
        // Only one card is face up, and we have found second that is match
        if cards[matchIndex] == cards[index] {
          cards[matchIndex].isMatched = true
          cards[index].isMatched = true
        }
        cards[index].isFaceUp = true
      } else {
        // either no cards or 2 cards are face up
        indexOfOneAndOnlyFaceUpCard  = index // Look at computing
      }
    }
  }
  
  
  mutating func restart() {
    for restartIndex in cards.indices {
      cards[restartIndex].isMatched = false
      cards[restartIndex].isFaceUp = false
    }
    cards.shuffle()
  }
  
  init(numberOfPairsOfCards: Int) {
    assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have almost one pair of cards")
    for _ in 0..<numberOfPairsOfCards {
      let card = Card()
      cards += [card, card]
      cards.shuffle()
    }
    /// To Do Shuffle the cards
  }
}

extension Collection {
  var oneAndOnly: Element? {
    return count == 1 ? first : nil
  }
}
