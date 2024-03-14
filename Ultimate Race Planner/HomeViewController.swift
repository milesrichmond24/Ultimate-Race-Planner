//
//  ViewController.swift
//  Ultimate Race Planner
//
//  Created by MILES RICHMOND on 3/4/24.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var planTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppData.getData()
        
        planTable.delegate = self
        planTable.dataSource = self
        planTable.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        planTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppData.plans.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "plan", for: indexPath) as! PlanCel
        cell.distance.text = "\(AppData.plans[indexPath.row].length) m"
        cell.name.text = "\(AppData.plans[indexPath.row].name)"
        cell.splitCount.text = "\(AppData.plans[indexPath.row].splits.count) Splits"
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        AppData.selectedPlan = indexPath.row
        performSegue(withIdentifier: "viewPlan", sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete) {
            AppData.plans.remove(at: indexPath.row)
            AppData.saveData()
            planTable.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? AddPlanViewController else {
            return
        }
        
        destination.delegate = self
    }
}
