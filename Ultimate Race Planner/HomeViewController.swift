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
        
        print(AppData.plans)
        
        
        planTable.delegate = self
        planTable.dataSource = self
        planTable.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        planTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppData.plans.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "plan", for: indexPath) as! PlanCel
        print(AppData.plans.count)
    
        return cell
    }
    
    @IBAction func test(_ sender: Any) {
        planTable.reloadData()
    }
}
