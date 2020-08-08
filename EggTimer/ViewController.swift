//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation



var audioPlayer : AVAudioPlayer?


class ViewController: UIViewController {
    
    let eggTimer=[
        "Soft" : 3 ,
        "Medium":4 ,
        "Hard":7
    ]
    var timer=Timer()
    
    var totaltime=0;
    var secondpassed=0;
    
    @IBOutlet weak var titlelabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBAction func eggDemand(_ sender: UIButton) {
        
        audioPlayer?.stop()
        
        titlelabel.text=" How do you like the egg? "
        progressBar.progress=0
//        every time it press is remove its previous setting timer
        timer.invalidate()
        secondpassed=0;
        let hardness=(sender.currentTitle!)
        
        totaltime=eggTimer[hardness]!
        
        
        
//        below function fires timeinterval every second it mention and call selector(function name) every time since it is objective function so function declartion statrt with @objc
        
        timer=Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    
    }
    
    @objc func update() {
        if(secondpassed < totaltime) {
            secondpassed+=1
            let percentage = (Float(secondpassed)/Float(totaltime))
            print(secondpassed,totaltime,percentage)
            progressBar.progress=Float(percentage)
            
        }else{
            let alarmPlay=Bundle.main.path(forResource: "alarm_sound", ofType: "mp3")
            let url=URL(fileURLWithPath: alarmPlay!)
            
            do {
            audioPlayer=try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
            }catch{
                
            }
            titlelabel.text=" DONE! "
        }
        
        
    }
}
