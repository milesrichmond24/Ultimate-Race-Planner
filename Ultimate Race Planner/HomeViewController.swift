//
//  ViewController.swift
//  Ultimate Race Planner
//
//  Created by MILES RICHMOND on 3/4/24.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        var race1 = Race(length: 1600, units: UnitLength.meters)
        
        race1.addSegment(length: 400, duration: 60)
        
        race1.setSegmentNote(segment: 0, "Cheesecake")
        race1.setSegmentNote(segment: 3, "Thnis")
        
        print(race1)
    }


}

