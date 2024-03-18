//
//  StopwatchViewController.swift
//  Ultimate Race Planner
//
//  Created by MILES RICHMOND on 3/14/24.
//

import UIKit

class StopwatchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var clock: UILabel!
    var clockValue: Double = 0.0 // Seconds
    var splits: [(TimeInterval, Float)] = []
    var selectedPlanIndex: Int = 0
    
    @IBOutlet weak var resetLapButton: UIButton!
    @IBOutlet weak var planSelect: UIPickerView!
    @IBOutlet weak var splitTable: UITableView!
    
    var stopwatchTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        splitTable.delegate = self
        splitTable.dataSource = self
        planSelect.delegate = self
        planSelect.dataSource = self
    }
    
    func updateClock() {
        clock.text = "\(clockValue)"
    }

    @IBAction func splitReset(_ sender: UIButton) {
        if stopwatchTimer != nil {
            let currentTime = clockValue
            splits.append((currentTime, Float.nan))
            
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
            
            resetLapButton.setTitle("Reset", for: .normal)
            resetLapButton.setTitleColor(.systemRed, for: .normal)
            resetLapButton.setTitleColor(.systemRed, for: .selected)
        } else {
            stopwatchTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (timer) in
                self.clockValue += timer.timeInterval
                
                self.clock.text = self.getFormattedTime(self.clockValue)
            })
            
            sender.setTitle("Stop", for: .normal)
            sender.setTitleColor(.systemRed, for: .normal)
            sender.setTitleColor(.systemRed, for: .selected)
            
            resetLapButton.setTitle("Lap", for: .normal)
            resetLapButton.setTitleColor(.systemGray, for: .normal)
            resetLapButton.setTitleColor(.systemGray, for: .selected)
        }
    }
    
    func getFormattedTime(_ t: TimeInterval) -> String {
        let minutes = Int(t) / 60 % 60
        let seconds = Int(t) % 60
        let milliseconds = Int(t * 100) % 100
        
        return "\(minutes):\(seconds).\(milliseconds)"
    }
    
    
    
    //
    //
    //
    // ---------------------------------------------------------------------------------------------
    //
    //
    //
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return splits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "split", for: indexPath) as! SplitCell
        
        cell.time.text = "\(getFormattedTime(splits[indexPath.row].0))"
        cell.distanceRange.text = "\(splits[indexPath.row].1)"
        let difference = splits[indexPath.row].1
        cell.difference.text = "\(difference)"
        
        return cell
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return AppData.plans.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return AppData.plans[row].name
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPlanIndex = row
        splitTable.reloadData()
    }
}
