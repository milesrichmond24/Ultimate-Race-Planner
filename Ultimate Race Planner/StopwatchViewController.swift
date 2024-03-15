//
//  StopwatchViewController.swift
//  Ultimate Race Planner
//
//  Created by MILES RICHMOND on 3/14/24.
//

import UIKit

class StopwatchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var clock: UILabel!
    var clockValue: Double = 0.0 // Seconds
    var splits: [(TimeInterval, Float)] = []
    @IBOutlet weak var splitTable: UITableView!
    
    var stopwatchTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        splitTable.delegate = self
        splitTable.dataSource = self
    }
    
    func updateClock() {
        clock.text = "\(clockValue)"
    }

    @IBAction func splitReset(_ sender: UIButton) {
        if let timer = stopwatchTimer {
            let currentTime = clockValue
            splits.append(currentTime)
            
            splitTable.reloadData()
            
            sender.setTitle("Lap", for: .normal)
            sender.setTitleColor(.systemGray, for: .normal)
            sender.setTitleColor(.systemGray, for: .selected)
        } else {
            clockValue = 0.0
            splits.removeAll()
            clock.text = getFormattedTime(0)
            
            splitTable.reloadData()
        }
        
        
    }
    
    @IBAction func startStop(_ sender: UIButton) {
        if let timer = stopwatchTimer {
            timer.invalidate()
            stopwatchTimer = nil
            sender.setTitle("Start", for: .normal)
            sender.setTitleColor(.systemGreen, for: .normal)
            sender.setTitleColor(.systemGreen, for: .selected)
        } else {
            stopwatchTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (timer) in
                self.clockValue += timer.timeInterval
                
                self.clock.text = self.getFormattedTime(self.clockValue)
            })
            
            sender.setTitle("Stop", for: .normal)
            sender.setTitleColor(.systemRed, for: .normal)
            sender.setTitleColor(.systemRed, for: .selected)
        }
    }
    
    func getFormattedTime(_ t: TimeInterval) -> String {
        let minutes = Int(t) / 60 % 60
        let seconds = Int(t) % 60
        let milliseconds = Int(t * 100) % 100
        
        return "\(minutes):\(seconds).\(milliseconds)"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return splits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "split", for: indexPath) as! SplitCell
        
        cell.time.text = "\(getFormattedTime(splits[indexPath.row]))"
        cell.distanceRange.text = ""
        
        return cell
    }
    
}
