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
    case superMegaHard
    static func getAllDifficulties() -> [Difficulty] {
        return [.easy, .medium, .hard, .extraHard, .superMegaHard]
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
        case .superMegaHard:
            return GameMode(maxValue: 250, modeName: "Супер-мега-сложный")
        }
    }
}

struct GameMode {
    var maxValue: Int
    var modeName: String
}

class Game {
    
    var mode: GameMode
    private var rounds: [Round] = [] {
        didSet {
            if rounds.count > 5 {
                rounds.remove(at: 5)
            }
        }
    }
    var roundsCount: Int {
        return rounds.count
    }
    init(withMode mode: GameMode) {
        self.mode = mode
        print("Game object created")
    }
    deinit {
        print("Game object deleted")
    }
    func finishGame() -> (message: String, result: Int) {
        var accuracyRate = 0
        for round in rounds {
            accuracyRate += round.getResultScore()
        }
        switch(accuracyRate) {
        case 0...10:
            return ("Превосходная точность! Вы победили.", accuracyRate)
        case 11...20:
            return ("Хорошая точность, но не идеал", accuracyRate)
        case 21...30:
            return ("Средний результат", accuracyRate)
        case 31...40:
            return ("Могло быть и лучше...", accuracyRate)
        case 41...50:
            return ("Вам точно следует подучиться точности!", accuracyRate)
        default:
            return ("Вы проиграли...", accuracyRate)
        }
    }
    
    func add(_ round: Round) {
        rounds.append(round)
    }
}

class Round {
    var expectedValue: Int
    private var selectedValue: Int?
    func getResultScore() -> Int {
        guard let selectedValue = selectedValue else {
            return 0
        }

        let tempValue = expectedValue - selectedValue
        return tempValue >= 0 ? tempValue : -tempValue
    }
    init(forGame game: Game) {
        expectedValue = Int.random(in: 0...game.mode.maxValue)
        print("Round object created")
    }
    deinit {
        print("Round object deleted")
    }
    
    func finishRound(with value: Int) {
        selectedValue = value
    }
    func getRoundResult() -> String {
        guard selectedValue != nil else { return "Ошибка" }
        switch(getResultScore()) {
        case 10...:
            return "Вы промахнулись слишком сильно."
        case 6...9:
            return "Далековато от истины!"
        case 3...5:
            return "Это было близко!"
        case 1...2:
            return "Вы были очень близки!"
        case 0:
            return"Вы идеально попали в нужное число!"
        default:
            return "Ошибка!"
        }
    }
}


