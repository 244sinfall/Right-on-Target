//
//  ViewController.swift
//  Right on Target
//
//  Created by Дмитрий Филин on 10.03.2022.
//

import UIKit


class WelcomeSceneVC: UIViewController {
    // Данный View Controller - меню игры, и не поддерживает горизонтальную ориентацию
    
    @IBAction func newGamePressed(_ sender: UIButton) {
        let difficultyAlert = UIAlertController(title: "Выберите сложность:", message: "Сложность определяет диапазон значений для выбора", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Отменить", style: .cancel, handler: nil)
        difficultyAlert.addAction(cancelAction)

        for mode in Difficulty.getAllDifficulties() {
            let modeInfo = mode.getDifficultyInfo()
            let newMode = UIAlertAction(title: modeInfo.modeName, style: .default) { _ in
                self.startGame(withDifficultyOf: modeInfo.maxValue)
            }
            difficultyAlert.addAction(newMode)
        }
//        let easyMode = UIAlertAction(title: "Легкая", style: .default) { _ in
//            self.startGame(withDifficultyOf: 50)
//        }
//        let mediumMode = UIAlertAction(title: "Средняя", style: .default) { _ in
//            self.startGame(withDifficultyOf: 100)
//        }
//        let hardMode = UIAlertAction(title: "Сложная", style: .default) { _ in
//            self.startGame(withDifficultyOf: 150)
//        }
//        difficultyAlert.addAction(easyMode)
//        difficultyAlert.addAction(mediumMode)
//        difficultyAlert.addAction(hardMode)

        present(difficultyAlert, animated: true, completion: nil)
    }
    @IBOutlet weak var newGameButton: UIButton!
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    private func startGame(withDifficultyOf difficulty: Int) {
        let gameVC = storyboard?.instantiateViewController(withIdentifier: "GameScene") as! gameViewController
        gameVC.difficulty = difficulty
        gameVC.modalPresentationStyle = .fullScreen
    
        show(gameVC, sender: self)
 
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        newGameButton.layer.shadowColor = UIColor.black.cgColor
        newGameButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        newGameButton.layer.shadowRadius = 3
        newGameButton.layer.shadowOpacity = 0.3
        // Do any additional setup after loading the view.
    }


}

