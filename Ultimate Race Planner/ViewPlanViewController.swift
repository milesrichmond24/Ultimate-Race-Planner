//
//  ViewPlanViewController.swift
//  Ultimate Race Planner
//
//  Created by Miles Richmond on 3/13/24.
//

import UIKit

class ViewPlanViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var targetPlan: Race!
    
    @IBOutlet weak var splitTable: UITableView!
    @IBOutlet weak var planName: UITextField!
    @IBOutlet weak var planDistance: UITextField!
    @IBOutlet weak var planNotes: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        splitTable.dataSource = self
        splitTable.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        targetPlan = AppData.plans[AppData.selectedPlan]
        
        planName.text = targetPlan.name
        planDistance.text = "\(targetPlan.length)"
        planNotes.text = targetPlan.notes
    }
    
    @IBAction func updatePlan() {
        AppData.plans[AppData.selectedPlan].name = planName.text!
        AppData.plans[AppData.selectedPlan].notes = planNotes.text!
        
        if let newLength = Float(planDistance.text!) {
            AppData.plans[AppData.selectedPlan].length = newLength
            print("\(newLength)")
        }
        
        // Honestly not sure if this line is needed, I forgot how references work
        targetPlan = AppData.plans[AppData.selectedPlan]
        
        AppData.saveData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return targetPlan.splits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "split", for: indexPath) as! SplitCell
        
        cell.time.text = "\(targetPlan.splits[indexPath.row].time) s"
        cell.distanceRange.text = "\(targetPlan.splits[indexPath.row].length) m"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete) {
            AppData.plans[AppData.selectedPlan].splits.remove(at: indexPath.row)
            targetPlan = AppData.plans[AppData.selectedPlan]
            AppData.saveData()
            splitTable.reloadData()
        }
    }
    
    @IBAction func addSplit(_ sender: UIButton) {
        let alertContr = UIAlertController(title: "Add Split", message: "", preferredStyle: .alert)
        alertContr.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Split Distance"
        })
        
        alertContr.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Split Time"
        })
        
        let save = UIAlertAction(title: "Add", style: .default, handler: { (_) in
            let len = Float(alertContr.textFields![0].text!)!
            let t = Double(alertContr.textFields![1].text!)!
            
            let segment = Segment(length: len, time: t, notes: "")
            AppData.plans[AppData.selectedPlan].splits.append(segment)
            self.targetPlan = AppData.plans[AppData.selectedPlan]
            AppData.saveData()
            
            self.splitTable.reloadData()
        })
        
        alertContr.addAction(save)
        alertContr.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertContr, animated: true, completion: nil)
    }
}
