//
//  AppData.swift
//  Ultimate Race Planner
//
//  Created by MILES RICHMOND on 3/12/24.
//

import Foundation

struct AppData {
    static var plans: [Race] = []
    static var selectedPlan: Int = 0
    
    static func saveData() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(plans) {
            UserDefaults.standard.set(encoded, forKey: "plans")
        }
    }
    
    static func getData() {
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.value(forKey: "plans") as? Data {
            if let decoded = try? decoder.decode([Race].self, from: data) {
                self.plans = decoded
            }
        }
        
    }
}
