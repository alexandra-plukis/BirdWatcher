//
//  MapViewController.swift
//  BirdWatcher
//
//  Created by Alexandra Plukis on 4/5/20.
//  Copyright © 2020 Alexandra Plukis. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class MapViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var mapType: UISegmentedControl!
    
    // handler to the managege object context
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //this is the array to store Fruit entities from the coredata
    var birdList = Birds()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setToolbarHidden(false, animated: false)
        loadBirds()
        showMap()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
             UIToolbar.appearance().overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setToolbarHidden(false, animated: false)
    }
    
    
    func loadBirds() {
        // Create a new fetch request using the BirdEntity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BirdEntity")
        // Execute the fetch request, and cast the results to an array of FruitEnity objects
        let fetchResults = ((try? managedObjectContext.fetch(fetchRequest)) as? [BirdEntity])!
        
        for entity in fetchResults {
            birdList.addBirdObject(name: entity.name!, desc: entity.desc!, pic: entity.picture!, lat: entity.latitude, long: entity.longitude, date: entity.date!)
        }
    }
    
    @IBAction func updateMap(_ sender: Any) {
        showMap()
    }
    
    func showMap() {
        switch(mapType.selectedSegmentIndex) {
            case 0:
                map.mapType = MKMapType.standard
            case 1:
                map.mapType = MKMapType.satellite
            case 2:
                map.mapType = MKMapType.hybrid
            default:
                map.mapType = MKMapType.standard
        }
        
        for bird in birdList.birdList {
            if let name = bird.birdName {
                let long: CLLocationDegrees = bird.birdLongitude // arizona if there is no response
                let lat: CLLocationDegrees = bird.birdLatitude // arizona if there is no response
                let span: MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.002, longitudeDelta: 0.002) 
                let coordinates = CLLocationCoordinate2D( latitude: lat, longitude: long)
                let region: MKCoordinateRegion = MKCoordinateRegion.init(center: coordinates, span: span)
                
                self.map.setRegion(region, animated: true)
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinates
                annotation.title = name
                
                self.map.addAnnotation(annotation)
            }
        }
    }
}
