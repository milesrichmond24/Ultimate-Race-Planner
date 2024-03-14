//
//  StopwatchViewController.swift
//  Ultimate Race Planner
//
//  Created by MILES RICHMOND on 3/14/24.
//

import UIKit

class StopwatchViewController: UIViewController {
    @IBOutlet weak var clock: UILabel!
    var clockValue: Double = 0.0 // Seconds
    @IBOutlet weak var planSelect: UIPickerView!
    
    var stopwatchTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateClock() {
        clock.text = "\(clockValue)"
    }

    @IBAction func splitReset(_ sender: UIButton) {
        
    }
    
    @IBAction func startStop(_ sender: UIButton) {
        if let timer = stopwatchTimer {
            timer.invalidate()
            stopwatchTimer = nil
            sender.titleLabel?.text = "Start"
        } else {
            clockValue = 0.0
            stopwatchTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (timer) in
                self.clockValue += timer.timeInterval
                
                self.clock.text = self.getFormattedTime(self.clockValue)
            })
        }
    }
    
    func getFormattedTime(_ t: TimeInterval) -> String {
        let minutes = Int(t) / 60 % 60
        let seconds = Int(t) % 60
        let milliseconds = Int(t * 100) % 100
        
        return "\(minutes):\(seconds).\(milliseconds)"
    }
}
