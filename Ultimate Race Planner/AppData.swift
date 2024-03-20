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
    
    static var log: [Race] = []
    
    static func saveData() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(plans) {
            UserDefaults.standard.set(encoded, forKey: "plans")
        }
        
        if let encoded = try? encoder.encode(log) {
            UserDefaults.standard.set(encoded, forKey: "log")
        }
    }
    
    static func getData() {
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.value(forKey: "plans") as? Data {
            if let decoded = try? decoder.decode([Race].self, from: data) {
                self.plans = decoded
            }
        }
        
        if let data = UserDefaults.standard.value(forKey: "log") as? Data {
            if let decoded = try? decoder.decode([Race].self, from: data) {
                self.log = decoded
            }
        }
        
    }
}
