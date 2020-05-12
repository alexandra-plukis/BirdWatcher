//
//  BirdEntity+CoreDataClass.swift
//  BirdWatcher
//
//  Created by Alexandra Plukis on 4/4/20.
//  Copyright © 2020 Alexandra Plukis. All rights reserved.
//
//

import Foundation
import CoreData
import MapKit

public class BirdEntity: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<BirdEntity> {
        return NSFetchRequest<BirdEntity>(entityName: "BirdEntity")
    }
    
    @NSManaged public var name: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var picture: NSData?
    @NSManaged public var date: NSDate?
    @NSManaged public var desc: String?
    
    func set(name: String, desc: String, pic: NSData, lat: Double, long: Double, date: NSDate) {
        self.name = name
        self.desc = desc
        self.picture = pic
        self.latitude = CLLocationDegrees(lat)
        self.longitude = CLLocationDegrees(long)
        self.date = date
    }
}
