//
//  ViewController.swift
//  Concentration-1
//
//  Created by Alexander Konovalov on 05.12.2020.
//

import UIKit

class ViewController: UIViewController {

  var numberOfPairsOfCards: Int {
    return cardButtons.count / 2
  }
  
  private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
  
  @IBOutlet private weak var flipCountLabel: UILabel!
  private(set) var flipCount = 0  {
    didSet {
      flipCountLabel.text = "FLIPS: \(flipCount)"
    }
  }
  
  @IBOutlet private var cardButtons: [UIButton]!
  
  
  @IBAction private func restartButton() {
    game.restart()
    UpdateViewFromModel()
    flipCount = 0
  }
  
  @IBAction private func touchCard(_ sender: UIButton) {
    flipCount += 1
    if let cardNumber = cardButtons.firstIndex(of: sender) { // Get the index of chosen card
      game.chooseCard(at: cardNumber)
      UpdateViewFromModel()
    }
  }
  
  private func UpdateViewFromModel() {
    for index in cardButtons.indices {
      let button = cardButtons[index]
      let card = game.cards[index]
      
      if card.isFaceUp {
        button.setTitle(emoji(for: card), for: UIControl.State.normal)
        button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
      } else {
        button.setTitle("", for: UIControl.State.normal) // What is normal and UIControl.State.normal
        button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 0) : #colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1)
      }
    }
  }
  
//  private var emojiContainer = ["🥷", "🎅🏻", "🗿", "📚", "🍉", "🍈", "🍔", "🍺", "🤖" , "🌚"]
  private var emojiContainer = "🥷🎅🏻🗿📚🍉🍈🍔🍺🤖🌚"
  
  private var emoji = [Card:String]() //  Dictionary
  
  private func emoji(for card: Card) -> String {
    if emoji[card] == nil, emojiContainer.count > 0 {
      let randomStringIndex = emojiContainer.index(emojiContainer.startIndex, offsetBy: emojiContainer.count.arc4random)
      emoji[card] = String(emojiContainer.remove(at: randomStringIndex))
    }
    return emoji[card] ?? "?"
  }
}

extension Int {
  var arc4random: Int {
    if self > 0 {
      return Int(arc4random_uniform(UInt32(self)))
    } else if self < 0 {
      return -Int(arc4random_uniform(UInt32(abs(self))))
    } else {
      return 0
    }
    
  }
}


//Observers - Наблюдатели
//Generic types
