//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var player: AVAudioPlayer!
    var dict = ["Soft":5,"Medium":10,"Hard":15]
    var secondsRemaining = 60
    var timer = Timer()
    
    
    @IBOutlet weak var ProgressBar: UIProgressView!
    @IBOutlet weak var HeadLine: UILabel!
    func progressRation(def:Double,sec:Double){
        let ratio:Double = Double((def-sec)/def)
        //print("\(def)-\(sec)=\(ratio)")
        //print("\((def-sec)/5)")
        self.ProgressBar.progress = Float(ratio)
    }

    func playSoundforSec() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: ".mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.player.stop()
        }
    }
    
    @IBAction func eggButton(_ sender: UIButton) {
        self.ProgressBar.progressTintColor=UIColor.orange
        self.HeadLine.text="How do you like your eggs?"
        timer.invalidate()
        self.ProgressBar.progress=0
        
        let hardness = sender.currentTitle!
        print(hardness)
        secondsRemaining = dict[hardness]!
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] (Timer) in
                if self.secondsRemaining > 0 {
                    self.progressRation(def: Double(self.dict[hardness]!), sec: Double(secondsRemaining))
                    print ("\(self.secondsRemaining) seconds")
                    self.secondsRemaining -= 1
                } else if self.secondsRemaining == 0 {
                    self.ProgressBar.progress=1.0
                    self.HeadLine.text="Done"
                    playSoundforSec()
                    let seconds = 3.0
                    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                        Timer.invalidate()
                        self.HeadLine.text="How do you like your eggs?"
                    }
                }
            }
        
    }
}
