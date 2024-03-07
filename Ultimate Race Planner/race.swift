//
//  race.swift
//  Ultimate Race Planner
//
//  Created by MILES RICHMOND on 3/4/24.
//

import Foundation

struct Race {
    var length: Float
    var units: UnitLength
    var splits: [Segment] = []
    
    var notes: String = ""
    
    init(length: Float, units: UnitLength) {
        self.length = length
        self.units = units
    }
    
    mutating func addSegment(_ segment: Segment) {
        var totalLength: Float = 0.0
        for split in splits {
            totalLength += split.length
        }
        
        guard (totalLength + segment.length <= length) else { return }
        
        splits.append(segment)
    }
    
    mutating func addSegment(length: Float, duration time: TimeInterval) {
        var totalLength: Float = 0.0
        for split in splits {
            totalLength += split.length
        }
        
        guard (totalLength + length <= length) else { return }
        
        splits.append(Segment(length: length, time: time, notes: ""))
    }
    
    mutating func setSegmentNote(segment: Int, _ note: String) {
        guard (segment < splits.count && segment >= 0) else { return }
        splits[segment].notes = note
    }
}

struct Segment {
    var length: Float
    var time: TimeInterval
    var notes: String
}
