//
//  GameText.swift
//  TypeBattle
//
//  Created by Fernando Jinzenji on 2018-09-28.
//  Copyright © 2018 Jimmy Hoang. All rights reserved.
//

import Foundation

class GameText {
    
    let quotes = ["Sometimes when you're in a dark place you think you've been buried, but you've actually been planted. Christine Caine",
                 "I may not have gone where I intended to go, but I think I have ended up where I needed to be. Douglas Adams",
                 "Inspiration comes from within yourself. One has to be positive. When you're positive, good things happen. Deep Roy",
                 "Optimism is essential to achievement and it is also the foundation of courage and true progress. Nicholas Butler",
                 "Instead of worrying about what you cannot control, shift your energy to what you can create. Roy Bennett",
                 "Put your heart, mind, and soul into even your smallest acts. This is the secret of success. Swami Sivananda",
                 "There are two great days in a person's life — the day we are born and the day we discover why. William Barclay",
                 "Clouds come floating into my life, no longer to carry rain or usher storm, but to add color to my sunset sky. Rabindranath Tagore"]
    
    let poems = ["I come with no wrapping or pretty pink bows. I am who I am, from my head to my toes. I tend to get loud when speaking my mind. Even a little crazy some of the time.",
                  "To those whom I've fought with and to those I don't know your name We fought by one another. You did not die in vain.",
                  "Simple Sam was a simple man. He lived each day by a simple plan. Enjoy your life and live while you can. Make each day count and take a stand.",
                  "What are heavy? Sea-sand and sorrow; What are brief? Today and tomorrow; What are frail? Spring blossoms and youth; What are deep? The ocean and truth."]
    
    func getRandomQuote() -> String {
        
        return quotes[Int.random(in: 0...quotes.count)].lowercased()
        
    }
    
    func getRandomPoem() -> String {
        
        return poems[Int.random(in: 0...poems.count)].lowercased()
        
    }
    
}
