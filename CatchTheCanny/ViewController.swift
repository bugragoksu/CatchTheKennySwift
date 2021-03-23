//
//  ViewController.swift
//  CatchTheCanny
//
//  Created by user187672 on 3/23/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    
    
    @IBOutlet weak var kennyImageView1: UIImageView!
    @IBOutlet weak var kennyImageView2: UIImageView!
    @IBOutlet weak var kennyImageView3: UIImageView!
    @IBOutlet weak var kennyImageView4: UIImageView!
    @IBOutlet weak var kennyImageView5: UIImageView!
    @IBOutlet weak var kennyImageView6: UIImageView!
    @IBOutlet weak var kennyImageView7: UIImageView!
    @IBOutlet weak var kennyImageView8: UIImageView!
    @IBOutlet weak var kennyImageView9: UIImageView!
    
    var imageViews=[UIImageView]()
    
    
    var score=0
    var highScore=0
    
    var timer=Timer()
    var randomImageTimer=Timer()
    var timeCount=10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imageViews=[kennyImageView1,kennyImageView2,kennyImageView3,kennyImageView4,kennyImageView5,kennyImageView6,kennyImageView7,kennyImageView8,kennyImageView9]
        
        for item in imageViews{
            item.isUserInteractionEnabled=true
            item.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageClicked)))
        }
        allImagesToHidden()
        startGame()
        
    }
    
    func startGame(){
        score=0
        timeCount=10
        scoreLabel.text="Score : 0"
        if let storageHighScore=UserDefaults.standard.string(forKey: "highScore"){
            if let storageHighScoreInt=Int(storageHighScore){
                highScore=storageHighScoreInt
            }
        }
        highscoreLabel.text="Highscore : \(highScore)"
        timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(counterTimerTick), userInfo: nil, repeats: true)
        randomImageTimer=Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(randomImagePickerTick), userInfo: nil, repeats: true)
    }
    
    
    @objc func randomImagePickerTick(){
        allImagesToHidden()
        let number=Int.random(in: 0..<9)
        imageViews[number].isHidden=false
    }
    
    @objc func imageClicked(){
        print("clicked")
        score += 1
        scoreLabel.text="Score : \(score)"
    }
    
    @objc func counterTimerTick(){
        timeCount -= 1
        timeLabel.text="Time : \(timeCount)"
        
        if(timeCount == 0){
            timer.invalidate()
            randomImageTimer.invalidate()
            finishGame()
        }
    }
    
    func finishGame(){
        if (score>highScore){
            saveHighScore()
        }
        allImagesToShow()
        for item in imageViews{
            item.isUserInteractionEnabled=false
        }
        
        showFinishAlert()
        
    }
    
    func showFinishAlert(){
        let alert=UIAlertController(title: "Time's up!", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
        let okButton=UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
        let replayButton=UIAlertAction(title: "Replay", style: UIAlertAction.Style.default, handler: {
            (UIAlertAction) in
            self.startGame()
        })
        
        alert.addAction(okButton)
        alert.addAction(replayButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func saveHighScore(){
        UserDefaults.standard.setValue(String(score), forKey: "highScore")
    }

    
    func allImagesToHidden(){
        for item in imageViews {
            item.isHidden=true
        }
    }
    
    func allImagesToShow(){
        for item in imageViews{
            item.isHidden=false
        }
    }

}

