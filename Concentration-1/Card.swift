//
//  Card.swift
//  Concentration-1
//
//  Created by Alexander Konovalov on 11.12.2020.
//

import Foundation

struct Card: Hashable
{
  func hash(into hasher: inout Hasher) {
    hasher.combine(identifier)
  }
  
  static func ==(lhs: Card, rhs: Card) -> Bool {
    return lhs.identifier == rhs.identifier
  }
  
  var isFaceUp = false
  var isMatched = false
  private var identifier: Int
  
  private static var identifierFactory = 0;
  
  private static func getUniqueIdentifier () -> Int {
    identifierFactory += 1
    return identifierFactory
  }
  
  init() {
    self.identifier = Card.getUniqueIdentifier()
  }
}
