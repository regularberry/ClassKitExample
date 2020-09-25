import Foundation
import UIKit

struct GameDataSource {
    static let shared = GameDataSource()
    
    let all: [Game] = [
        Game(
            backgroundColor: UIColor(red: 1.0, green: 0.85, blue: 1.0, alpha: 1.0),
            identifier: "MATH-JAM",
            keywords: ["math", "game"],
            summary: "Tap the math button as many times as you can.",
            symbolGenerator: { String(Array(0...9).randomElement() ?? 0) },
            title: "Math Jam",
            topic: .math
        ),
        Game(
            backgroundColor: UIColor(red: 1.0, green: 0.85, blue: 0.85, alpha: 1.0),
            identifier: "WORD-JAM",
            keywords: ["writing", "game"],
            summary: "Tap the writing button as many times as you can.",
            symbolGenerator: { String("ABCDEFGHIJKLMNOPQRSTUVWXYZ".randomElement() ?? "A") },
            title: "Word Jam",
            topic: .literacyAndWriting
        )
    ]
    
    func game(from id: String) -> Game? {
        return all.first(where: { $0.identifier == id })
    }
}
