//
//  ViewController.swift
//  CatchTheGumball
//
//  Created by Vedat Dokuzkardeş on 8.11.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var score = 0
    var hideTimer = Timer()
    var timer = Timer()
    var counter = 0
    var tomArray = [UIImageView]()
    var highScore = 0

    @IBOutlet weak var hScoreLbl: UILabel!
    @IBOutlet weak var scoreLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    
    @IBOutlet weak var tom1: UIImageView!
    @IBOutlet weak var tom2: UIImageView!
    @IBOutlet weak var tom3: UIImageView!
    @IBOutlet weak var tom4: UIImageView!
    @IBOutlet weak var tom5: UIImageView!
    @IBOutlet weak var tom6: UIImageView!
    @IBOutlet weak var tom7: UIImageView!
    @IBOutlet weak var tom8: UIImageView!
    @IBOutlet weak var tom9: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLbl.text = "Score: \(score)"
        
        //highscore check
        
        let savedHighScore = UserDefaults.standard.object(forKey: "hscore")
        
        if savedHighScore == nil {
            highScore = 0
            hScoreLbl.text = "Highscore: \(highScore)"
        }
        
        if let newScore = savedHighScore as? Int {
            highScore = newScore
            hScoreLbl.text = "Highscore: \(highScore)"
        }
        
        tom1.isUserInteractionEnabled = true
        tom2.isUserInteractionEnabled = true
        tom3.isUserInteractionEnabled = true
        tom4.isUserInteractionEnabled = true
        tom5.isUserInteractionEnabled = true
        tom6.isUserInteractionEnabled = true
        tom7.isUserInteractionEnabled = true
        tom8.isUserInteractionEnabled = true
        tom9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        tom1.addGestureRecognizer(recognizer1)
        tom2.addGestureRecognizer(recognizer2)
        tom3.addGestureRecognizer(recognizer3)
        tom4.addGestureRecognizer(recognizer4)
        tom5.addGestureRecognizer(recognizer5)
        tom6.addGestureRecognizer(recognizer6)
        tom7.addGestureRecognizer(recognizer7)
        tom8.addGestureRecognizer(recognizer8)
        tom9.addGestureRecognizer(recognizer9)
        
        tomArray = [tom1,tom2,tom3,tom4,tom5,tom6,tom7,tom8,tom9]
        
        //Timers
        counter = 10
        timeLbl.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideTom), userInfo: nil, repeats: true)
        
        hideTom()
    }
    
   @objc func hideTom(){
        
        for tom in tomArray {
            tom.isHidden = true
        }
        
       let random = Int(arc4random_uniform(UInt32(tomArray.count - 1)))
        tomArray[random].isHidden = false
        
    }
    
    @objc func increaseScore() {
        
        score += 1
        scoreLbl.text = "Score: \(score)"
        
    }
    
    @objc func countDown(){
        
        counter -= 1
        timeLbl.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for tom in tomArray {
                tom.isHidden = true
            }
            
            if self.score > self.highScore {
                self.highScore = self.score
                hScoreLbl.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.setValue(self.highScore, forKey: "hscore")
            }
            
            //Alert
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { [self] (UIAlertAction) in
                
                //replay function
                self.score = 0
                self.scoreLbl.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLbl.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideTom), userInfo: nil, repeats: true)
                
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
            
            
            
            
        }
        
    }

}

