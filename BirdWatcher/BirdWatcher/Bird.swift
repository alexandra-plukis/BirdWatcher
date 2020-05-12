//
//  Bird.swift
//  BirdWatcher
//
//  Created by Alexandra Plukis on 4/4/20.
//  Copyright © 2020 Alexandra Plukis. All rights reserved.
//

import Foundation
import MapKit
import Foundation

class Birds
{
    var birdList:[Bird] = []
    
    
    func getCount() -> Int
    {
        return self.birdList.count
    }
    
    func getBirdObject(item: Int) -> Bird {
        
        return self.birdList[item]
    }
    
    func removeBirdObject(item:Int) {
        
        self.birdList.remove(at: item)
    }
    
    func addBirdObject(name: String, desc: String, pic: NSData, lat: Double, long: Double, date: NSDate) {
        let bird = Bird(name: name, desc: desc, pic: pic, lat: lat, long: long, date: date)
        self.birdList.append(bird)
    }
    
    func removeAll() {
        birdList.removeAll()
    }
}

class Bird
{
    var birdName: String?
    var birdLatitude: Double
    var birdLongitude: Double
    var birdPicture: NSData?
    var birdDate: NSDate?
    var birdDesc: String?
    
    init(name: String, desc: String, pic: NSData, lat: Double, long: Double, date: NSDate) {
        self.birdName = name
        self.birdDesc = desc
        self.birdPicture = pic
        self.birdLatitude = CLLocationDegrees(lat)
        self.birdLongitude = CLLocationDegrees(long)
        self.birdDate = date
    }
    
    init() {
        self.birdName = nil
        self.birdDesc = nil
        self.birdPicture = nil
        self.birdLatitude = 0.0
        self.birdLongitude = 0.0
        self.birdDate = nil
    }
    
}
