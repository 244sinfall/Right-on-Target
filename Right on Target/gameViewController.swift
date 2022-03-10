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

    var gameInstance: Game!
    var currentRound: Round!
    @IBOutlet weak var minValueLabel: UILabel!
    @IBOutlet weak var maxValueLabel: UILabel!
    @IBOutlet weak var roundCounterLabel: UILabel!
    @IBOutlet weak var neededDigitLabel: UILabel!
    
    @IBAction func completeRound(_ sender: UIButton) {
        currentRound.finishRound(with: Int(gameSlider.value))
        let message = currentRound.getRoundResult()
        gameInstance.add(currentRound)
        let roundSwitchAlert = UIAlertController(title: "Результат раунда", message: message, preferredStyle: .alert)
        if gameInstance.roundsCount == 5 {
            let (finalMessage, finalScore) = gameInstance.finishGame()
            roundSwitchAlert.message = finalMessage
            let accuracy: Double = 100-(Double(finalScore)/(Double(gameInstance.mode.maxValue)*5)*100)
            roundSwitchAlert.title = "Ваша точность: \(accuracy)%"
            let lastRoundConfirmation = UIAlertAction(title: "Выход", style: .destructive) { _ in
                self.dismiss(animated: true, completion: nil)
            }
            roundSwitchAlert.addAction(lastRoundConfirmation)
            present(roundSwitchAlert, animated: true, completion: nil)
        }
        else {
            let roundSwitchConfirmation = UIAlertAction(title: "OK", style: .default) { _ in
                self.startNew(round: Round(forGame: self.gameInstance))
            }
            roundSwitchAlert.addAction(roundSwitchConfirmation)
            present(roundSwitchAlert, animated: true, completion: nil)
        }
    }
    
    @IBOutlet weak var gameSlider: UISlider!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let difficulty = gameInstance.mode.maxValue
        gameSlider.minimumValue = 0
        gameSlider.maximumValue = Float(difficulty)
        
        minValueLabel.text = String(0)
        maxValueLabel.text = String(difficulty)
        startNew(round: Round(forGame: gameInstance))
        // Do any additional setup after loading the view.
    }
    
    func startNew(round: Round) {
        currentRound = round
        gameSlider.value = Float(gameInstance.mode.maxValue/2)
        neededDigitLabel.text = "Необходимое число: \(round.expectedValue)"
        roundCounterLabel.text = "Раунд: \(gameInstance.roundsCount+1)/5"
        
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
