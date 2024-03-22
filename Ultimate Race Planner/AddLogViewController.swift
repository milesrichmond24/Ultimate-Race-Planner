//
//  AddLogViewController.swift
//  Ultimate Race Planner
//
//  Created by MILES RICHMOND on 3/20/24.
//

import UIKit

class AddLogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var plan: Int = 0
    var splits: [(TimeInterval, TimeInterval)] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        if(plan >= AppData.plans.count) {
            
        } else {
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "split", for: indexPath) as? SplitCell
        
        if(plan < AppData.plans.count) {
            cell.distanceRange = "\(AppData.plans[plan].length) m"
        }
        cell?.time
    }
}
