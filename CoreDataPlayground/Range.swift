//
//  Student.swift
//  CoreDataPlayground
//
//  Created by Qantas Dev on 30/4/19.
//  Copyright © 2019 Qantas Airways Flight Technical. All rights reserved.
//

import Foundation

public class Ranges: NSObject, NSCoding {
    
    public var ranges: [Range] = []
    
    enum Key:String {
        case ranges = "ranges"
    }
    
    init(ranges: [Range]) {
        self.ranges = ranges
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(ranges, forKey: Key.ranges.rawValue)
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        let mRanges = aDecoder.decodeObject(forKey: Key.ranges.rawValue) as! [Range]
        
        self.init(ranges: mRanges)
    }
    
    
}

public class Range: NSObject, NSCoding {
    
    public var location: Int = 0
    public var length: Int = 0
    
    enum Key:String {
        case location = "location"
        case length = "length"
    }
    
    init(location: Int, length: Int) {
        self.location = location
        self.length = length
    }
    
    public override init() {
        super.init()
    }
    
    public func encode(with aCoder: NSCoder) {
        
        aCoder.encode(location, forKey: Key.location.rawValue)
        aCoder.encode(length, forKey: Key.length.rawValue)
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        
        let mlocation = aDecoder.decodeInt32(forKey: Key.location.rawValue)
        let mlength = aDecoder.decodeInt32(forKey: Key.length.rawValue)
        
        self.init(location: Int(mlocation), length:
            Int(mlength))
    }
}


