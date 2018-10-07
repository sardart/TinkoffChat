//
//  ConversationsManager.swift
//  TinkoffChat
//
//  Created by Artur on 07/10/2018.
//  Copyright © 2018 Artur Sardaryan. All rights reserved.
//

import Foundation

class ConversationsManager {
    
    func getConversations(count: Int, online: Bool) -> [Conversation] {
        var conversations = [Conversation]()
        var i = 0
        while i < count {
            conversations.append(Conversation(name: randomName(), message: randomMessage(), date: randomDate(), online: online, hasUnreadMessages: randomBool()))
            i += 1
        }
        
        return conversations
    }
    
    func getMessages(count: Int) -> [Message] {
        var messages = [Message]()
        var i = 0
        while i < count {
            messages.append(Message(messageText: randomMessage(withoutNil: true), type: randomMessageType()))
            i += 1
        }
        return messages
    }
    
    private func randomName() -> String {
        if names.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(names.count)))
            return names.remove(at: randomIndex)
        } else {
            return "Default Name"
        }
    }
    
    private func randomBool() -> Bool {
        let randomNumber = Int(arc4random_uniform(2))
        if randomNumber == 0 {
            return true
        } else {
            return false
        }
    }
    
    private func randomMessageType() -> MessageType {
        let randomNumber = Int(arc4random_uniform(2))
        if randomNumber == 0 {
            return .incoming
        } else {
            return .outgoing
        }
    }
    
    private func randomDate() -> Date {
        let randomTimeInterval = -1 * TimeInterval(arc4random_uniform(96*3600))
        let randomDate = Date(timeIntervalSinceNow: randomTimeInterval)
        return randomDate
    }
    
    private func randomMessage(withoutNil: Bool = false) -> String? {
        let randomIndex = Int(arc4random_uniform(UInt32(messages.count)))
        let randomMessage = messages[randomIndex]
        if withoutNil {
            return randomMessage
        } 
        
        let randomNumber = Int(arc4random_uniform(3))
        if randomNumber == 0 {
            return nil
        } else {
            return randomMessage
        }
    }
    
    var names = [
        "Young Mcleish",
        "Lavette Tarwater",
        "So Arden",
        "Enedina Gheen",
        "Barrett Weirich",
        "Von Newman",
        "Elvin Klinger",
        "Kristan Golightly",
        "Leann Ebner",
        "Demetra Fikes",
        "Shenna Hadden",
        "Dorthy Truman",
        "Wendy Heaston",
        "Malika Gamino",
        "Addie Agar",
        "Chi Hail",
        "Margit Siems",
        "Judie Fincher",
        "Denisse Menges",
        "Kayleigh Merrifield",
        "Cythia Cerny",
        "Lea Subia",
        "Madaline Mackley",
        "Agustin Daughdrill",
        "Olene Yip",
        "Gilma Boster",
        "Nedra Marsden",
        "Yolando Menter",
        "Roy Lewellen",
        "Berneice Mcmillan",
        "Shonna Barnard",
        "Maire Paddock",
        "Pamula Auslander",
        "Neal Mccuen",
        "Maddie Laffey",
        "Edwina Tarleton",
        "Patti Bartram",
        "Abe Shipley",
        "Thomasine Desai",
        "Aurea Millen",
        "Dell Lahti",
        "Taren Epley",
        "Mitchell Holzinger",
        "Gabriela Mcfarland",
        "Howard Warren",
        "Joesph Ashley",
        "Florencio Galvan",
        "Brendon Lozano",
        "Francisco Morales",
        "Lelia Reyes",
        "Alana Mccann",
        "Wanda Fry",
        "Martha Stephenson"
    ]
    
    var messages = [
        "She borrowed the book from him many years ago and hasn't yet returned it.",
        "Italy is my favorite country; in fact, I plan to spend two weeks there next year.",
        "I want more detailed information.",
        "I think I will buy the red car, or I will lease the blue one.",
        "A purple pig and a green donkey flew a kite in the middle of the night and ended up sunburnt.",
        "He said he was not there yesterday; however, many people saw him there.",
        "If the Easter Bunny and the Tooth Fairy had babies would they take your teeth and leave chocolate for you?",
        "I would have gotten the promotion, but my attendance wasn’t good enough.",
        "I really want to go to work, but I am too sick to drive.",
        "Wow, does that work?",
        "Two seats were vacant.",
        "Lets all be unique together until we realise we are all the same.",
        "We have never been to Asia, nor have we visited Africa.",
        "Sometimes, all you need to do is completely make an ass of yourself and laugh it off to realise that life isn’t so bad after all.",
        "Please wait outside of the house.",
        "Everyone was busy, so I went to the movie alone.",
        "The stranger officiates the meal.",
        "Tom got a small piece of pie.",
        "I hear that Nancy is very pretty.",
        "A song can make or ruin a person’s day if they let it get to them.",
        "My Mum tries to be cool by saying that she likes all the same things that I do.",
        "They got there early, and they got really good seats.",
        "Sometimes it is better to just walk away from things and go back to them later when you’re in a better frame of mind.",
        "She wrote him a long letter, but he didn't read it.",
        "Hello world",
        "How was the math test?",
        "This is a Japanese doll.",
        "The memory we used to share is no longer coherent.",
        "The waves were crashing on the shore; it was a lovely sight.",
        "She only paints with bold colors; she does not like pastels.",
        "Abstraction is often one floor above you.",
        "She did not cheat on the test, for it was not the right thing to do.",
        "I want to buy a onesie… but know it won’t suit me.",
        "Cats are good pets, for they are clean and are not noisy.",
        "Is it free?",
        "He said he was not there yesterday; however, many people saw him there.",
        "Rock music approaches at high velocity.",
        "The shooter says goodbye to his love.",
        "How are you?",
        "I am fine!",
        "Will see.",
        "Miss you :("
    ]
    
    
}
