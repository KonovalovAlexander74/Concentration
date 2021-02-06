//
//  ViewController.swift
//  Concentration-1
//
//  Created by Alexander Konovalov on 05.12.2020.
//

import UIKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    themeIndex = emojiThemesCollection.count.arc4random
    UpdateViewFromModel()
    updateAppearence()
  }

  var numberOfPairsOfCards: Int {
    return cardButtons.count / 2
  }
  
  private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
  
  @IBOutlet private weak var flipCountLabel: UILabel!

  @IBOutlet weak var gameScoreLabel: UILabel!
  
  @IBOutlet private var cardButtons: [UIButton]!
  
  
  @IBOutlet weak var restartButton: UIButton!
  @IBAction private func restart() {
    themeIndex = emojiThemesCollection.count.arc4random
    game.restart()
    UpdateViewFromModel()
    updateAppearence()
  }
  
  @IBAction private func touchCard(_ sender: UIButton) {
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
        button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 0) : cardBackColor
      }
    }
    flipCountLabel.text = "FLIPS: \(game.flipCount)"
    gameScoreLabel.text = "SCORE: \(game.scoreCount)"
  }
  
  private func updateAppearence() {
    view.backgroundColor = backgroundColor
    flipCountLabel.textColor = cardBackColor
    gameScoreLabel.textColor = cardBackColor
    restartButton.backgroundColor = cardBackColor
    restartButton.setTitleColor(backgroundColor, for: .normal)
  }
  
  typealias Theme = (emojiChoises: String, backgroundColor: UIColor, cardBackColor: UIColor)
  
  var emojiThemesCollection: [Theme] = [
    ("🥷🎅🏻🗿📚🍉🍈🍔🍺🤖🌚", #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)),
    ("🐶🐱🐰🦊🐻🐵🐷🐮🐯🦁", #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1), #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)),
    ("🏀🥎🪃⛸🎱🥏⚽️🥊🛹🚴🏻‍♀️", #colorLiteral(red: 1, green: 0.9333333373, blue: 0.7450980544, alpha: 1), #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)),
    ("🚙🚞🚒🏎🚠🚲🛴🛵🦼🚛", #colorLiteral(red: 0.3333333333, green: 0.7450980392, blue: 0.9411764706, alpha: 1), #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)),
    ("📞☎️⏰📺📻📟⌚️📱💻🕹", #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)),
    ("❤️🧡💛💚💙💜🖤🤍🤎💔", #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)),
    ("🕐🕑🕒🕓🕔🕕🕖🕗🕘🕤", #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)),
    ("🐊🐪🐏🐃🦍🦧🦃🐕🦒🐆", #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1), #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)),
    ("😅🥰😈😎😡🥶😱🤢😇🥺", #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1))]
  
  private var backgroundColor = UIColor()
  private var cardBackColor = UIColor()
  
  private var themeIndex = 0 {
    didSet {
      (emojiCollection, backgroundColor, cardBackColor) = emojiThemesCollection[themeIndex]
      emoji = [Card:String]()
    }
  }
  
  private var emojiCollection = String()
  private var emoji = [Card:String]() //  Dictionary
  
  private func emoji(for card: Card) -> String {
    if emoji[card] == nil, emojiCollection.count > 0 {
      let randomStringIndex = emojiCollection.index(emojiCollection.startIndex, offsetBy: emojiCollection.count.arc4random)
      emoji[card] = String(emojiCollection.remove(at: randomStringIndex))
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
