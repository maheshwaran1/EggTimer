//
//  ViewController.swift
//  Egg Timer
//
//  Created by Maheshwaran on 16/02/22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    var player: AVAudioPlayer!
    
    //dictionary - Boiling time for Eggs
    let eggTimes = ["Soft":3, "Medium": 40, "Hard": 70]
    
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    
   
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        //end timer
        timer.invalidate()
        let hardness = sender.currentTitle! // Soft,Medium, Hard
        
        //progress bar
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        totalTime = eggTimes[hardness]!
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            //progress bar
            progressBar.progress = Float(secondsPassed)/Float(totalTime)
            
            
        } else {
            timer.invalidate()
            titleLabel.text = "Done!, have your Egg"
            
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
    
}
