//
//  AddPlanViewController.swift
//  Ultimate Race Planner
//
//  Created by MILES RICHMOND on 3/12/24.
//

import UIKit

class AddPlanViewController: UIViewController {
    var delegate: HomeViewController!
    var name: String!
    var distance: Float!
    var notes: String!
    
    var isValid: Bool = false
    var isDistValid: Bool = false

    @IBOutlet weak var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate.planTable.reloadData()
    }
    
    
    @IBAction func addPlan(_ sender: UIButton) {
        if(!isValid) {
            return
        }
        
        var plan: Race = Race(length: distance, units: UnitLength.meters)
        plan.name = name
        plan.notes = notes
        
        AppData.plans.append(plan)
        print(AppData.plans.last)
    }
    
    @IBAction func updateTitle(_ sender: UITextField) {
        name = sender.text
        checkValid()
    }
    
    @IBAction func updateDistance(_ sender: UITextField) {
        if let dist = Float(sender.text!) {
            distance = dist
            isDistValid = true
        } else {
            isDistValid = false
        }
        checkValid()
    }
    
    @IBAction func updateNotes(_ sender: UITextField) {
        notes = sender.text
        checkValid()
    }
    
    func checkValid() {
        if let _ = name {
            if let _ = notes {
                if isDistValid {
                    addButton.tintColor = .link
                    isValid = true
                    return
                }
            }
        }
        
        addButton.tintColor = .systemGray
        isValid = false
    }
}
