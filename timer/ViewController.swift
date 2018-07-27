//
//  ViewController.swift
//  timer
//
//  Created by Aleksandr Ohotnikov on 23.07.2018.
//  Copyright © 2018 Aleksandr Ohotnikov. All rights reserved.
//

import UIKit
import AudioToolbox


class ViewController: UIViewController {
    
    var currentTimer = 6000
    var timer = Timer()
    var startClicked = false
    

        // ---- All buttons
    @IBOutlet weak var TimerCount: UILabel!
    
    @IBOutlet weak var milSecond: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var resetButton: UIButton!
    //------- +++++ -----

    func setedTimerView(time: Int){
        var secondsFix
            : String? = ""
        var _
            : String? = ""
        let secondsCeil = time / 100
        let milsecondsCeil = String(time)
        if (secondsCeil < 10) {
           secondsFix = "0"
        }
    
        TimerCount.text = "\(secondsFix!)\(secondsCeil)"
    
        milSecond.text = "\(milsecondsCeil[milsecondsCeil.index(milsecondsCeil.startIndex, offsetBy: 2)..<milsecondsCeil.endIndex])"
    }
    func changeTimerState(state: String) {
        switch state {
        case "start":
            startButton.setTitle(NSLocalizedString("stop", comment: ""), for: .normal)
            startTimer()
            setedTimerView(time: currentTimer)
            break
        case "stop":
            startButton.setTitle(NSLocalizedString("start", comment: ""), for: .normal)
            timer.invalidate()
            break
        case "reset":
            changeTimerState(state: "stop")
            TimerCount.text = NSLocalizedString("reseted", comment: "reseted")
            milSecond.text = ""
            currentTimer = 6000
            startClicked = false
            break
        default:
            break
        }
    }
    
    
    // All Actions ::
    @IBAction func startClicked(_ sender: UIButton) {
        startClicked = !startClicked
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        if startClicked {
            changeTimerState(state: "start")
        } else {
            changeTimerState(state: "stop")
        }
        
    }
    
    @IBAction func resetClicked(_ sender: Any) {
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        changeTimerState(state: "reset")
    }

    ///=======
    
   
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
    }
    
    
    @objc func updateTimer() {
        currentTimer -= 1;
        setedTimerView(time: currentTimer)
        if (currentTimer < 0) {
            changeTimerState(state: "reset")
            TimerCount.text = "🏁 Finish!"
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TimerCount.text = NSLocalizedString("startMessage", comment: "")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

