//
//  Model.swift
//  Right on Target
//
//  Created by Дмитрий Филин on 10.03.2022.
//

import Foundation

enum Difficulty {
    case easy
    case medium
    case hard
    case extraHard
    static func getAllDifficulties() -> [Difficulty] {
        return [.easy, .medium, .hard, .extraHard]
    }
    func getDifficultyInfo() -> GameMode {
        switch self {
        case .easy:
            return GameMode(maxValue: 50, modeName: "Легкий")
        case .medium:
            return GameMode(maxValue: 100, modeName: "Средний")
        case .hard:
            return GameMode(maxValue: 150, modeName: "Сложный")
        case .extraHard:
            return GameMode(maxValue: 200, modeName: "Супер-сложный")
        }
    }
}

struct GameMode {
    var maxValue: Int
    var modeName: String
}
