//
//  AddViewController.swift
//  BirdWatcher
//
//  Created by Alexandra Plukis on 3/22/20.
//  Copyright © 2020 Alexandra Plukis. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

class AddViewController: UIViewController, CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var logField: UITextView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var photoButton: RoundUIButton!
    let picker = UIImagePickerController()
    var photoChosen: NSData = UIImage(named: "bird.png")!.pngData()! as NSData // this is the default
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setToolbarHidden(false, animated: false)
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
            navigationController?.overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setToolbarHidden(false, animated: false)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // needs to be here for manager
    }
    
    
    @IBAction func addSighting(_ sender: Any) {      
        
        if (nameField.text! == "") {
            return // don't want to add empty bird
        }
        // create a new entity object
        let ent = NSEntityDescription.entity(forEntityName: "BirdEntity", in: self.managedObjectContext)
        //add to the manege object context
        
        let newItem = BirdEntity(entity: ent!, insertInto: self.managedObjectContext)
        if let name = nameField.text, let desc = logField.text {
            var latitude = 36.0
            var longitude = -86.0
            if let sourcelocation = self.locationManager.location?.coordinate {
                latitude = Double((sourcelocation.latitude))
                longitude = Double((sourcelocation.longitude))
            }
            let currentDateTime = Date()

            newItem.set(name: name, desc: desc, pic: photoChosen, lat: latitude, long: longitude, date: currentDateTime as NSDate)
        }
        
        // save the updated context
        do {
            try self.managedObjectContext.save()
        } catch _ {
            // nothing here
        }
        
        clearFields()
    }
    
    func clearFields() {
        nameField.text = ""
        logField.text = ""
        photoChosen = UIImage(named: "bird.png")!.pngData()! as NSData // this is the default
    }
    
    @IBAction func getPhotoFromLibrary(_ sender: Any) {
        let photoPicker = UIImagePickerController()
        photoPicker.delegate = self 
        photoPicker.sourceType = .photoLibrary
        // display image selection view
        self.present(photoPicker, animated: true, completion: nil)
    }
    
    @IBAction func getPhotoFromCamera(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        } 
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker .dismiss(animated: true, completion: nil)

        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.photoChosen = image.pngData()! as NSData
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
}
