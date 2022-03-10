//
//  gameViewController.swift
//  Right on Target
//
//  Created by Дмитрий Филин on 10.03.2022.
//

import UIKit


class gameViewController: UIViewController {
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .init(arrayLiteral: .landscape, .landscapeLeft, .landscapeRight)
    }
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .landscapeLeft
    }
    var difficulty: Int = 0
    var scorePoints: Int = 0
    var roundCounter: Int = 0
    var expectedResult: Int?
    @IBOutlet weak var minValueLabel: UILabel!
    @IBOutlet weak var maxValueLabel: UILabel!
    @IBOutlet weak var roundCounterLabel: UILabel!
    @IBOutlet weak var neededDigitLabel: UILabel!
    
    @IBAction func completeRound(_ sender: UIButton) {
        let answerValue = gameSlider.value
        guard let needed = expectedResult else { return }
        let resultValue = Int(answerValue) - needed
        let result = resultValue >= 0 ? resultValue : -resultValue
        var message: String = ""
        switch(result) {
        case 10...:
            message = "Вы промахнулись слишком сильно. Этот раунд без очков..."
        case 6...9:
            message = "Вы получили 3 очка. Далековато от истины!"
            scorePoints += 3
        case 3...5:
            message = "Вы получили 6 очков. Это было близко!"
            scorePoints += 6
        case 1...2:
            message = "Вы были очень близки! Получаете 8 очков!"
            scorePoints += 8
        case 0:
            message = "Вы идеально попали в нужное число и получаете 10 очков!"
            scorePoints += 10
        default:
            message = "Ошибка!"
        }
        roundCounter += 1
        let roundSwitchAlert = UIAlertController(title: "Результат раунда", message: message, preferredStyle: .alert)
        if roundCounter == 5 {
            roundSwitchAlert.title = "Результат игры: \(scorePoints) очков"
            let lastRoundConfirmation = UIAlertAction(title: "Выход", style: .destructive) { _ in
                self.dismiss(animated: true, completion: nil)
            }
            roundSwitchAlert.addAction(lastRoundConfirmation)
            present(roundSwitchAlert, animated: true, completion: nil)
        }
        else {
            let roundSwitchConfirmation = UIAlertAction(title: "OK", style: .default) { _ in
                self.startNewRound(round: self.roundCounter)
            }
            roundSwitchAlert.addAction(roundSwitchConfirmation)
            present(roundSwitchAlert, animated: true, completion: nil)
        }
    }
    
    @IBOutlet weak var gameSlider: UISlider!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        gameSlider.minimumValue = 0
        gameSlider.maximumValue = Float(difficulty)
        
        minValueLabel.text = String(0)
        maxValueLabel.text = String(difficulty)
        
        startNewRound(round: roundCounter)
        // Do any additional setup after loading the view.
    }
    
    func startNewRound(round: Int) {
        
        expectedResult = Int.random(in: 0...difficulty)
        gameSlider.value = Float(difficulty/2)
        neededDigitLabel.text = "Необходимое число: \(expectedResult!)"
        roundCounterLabel.text = "Раунд: \(round+1)/5"
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
