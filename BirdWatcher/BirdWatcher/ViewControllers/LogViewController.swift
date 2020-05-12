//
//  LogViewController.swift
//  BirdWatcher
//
//  Created by Alexandra Plukis on 3/23/20.
//  Copyright © 2020 Alexandra Plukis. All rights reserved.
//

import UIKit
import CoreData

class LogViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //model
    var birdList = Birds()
    
    // handler to the managege object context
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //this is the array to store Fruit entities from the coredata
    var fetchResults = [BirdEntity]()
        
    @IBOutlet weak var tableView: UITableView!
    //model
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setToolbarHidden(false, animated: false)
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
            UINavigationBar.appearance().overrideUserInterfaceStyle = .light
            UIToolbar.appearance().overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    func fetchRecord() -> Int {
        
        // Create a new fetch request using the BirdEntity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BirdEntity")
        var count = 0
        
        // Execute the fetch request, and cast the results to an array of FruitEnity objects
        fetchResults = ((try? managedObjectContext.fetch(fetchRequest)) as? [BirdEntity])!
        
        birdList.removeAll()
        
        for entity in fetchResults {
            birdList.addBirdObject(name: entity.name!, desc: entity.desc!, pic: entity.picture!, lat: entity.latitude, long: entity.longitude, date: entity.date!)
        }
        
        count = fetchResults.count
        
        // return how many entities in the coreData
        return count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "birdCell", for: indexPath) as! BirdTableViewCell
        
        // calling the model to get the fruit object each row
        let birdItem = birdList.getBirdObject(item: indexPath.row)
        
        cell.birdName.text = birdItem.birdName!
        cell.birdImage.image = UIImage(data: birdItem.birdPicture! as Data)
        
        //cell.fruitImage.image = UIImage(named: fruitItem.fruitImageName!)
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchRecord()
    }
    
    // delete table entry
    // this method makes each row editable
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    // return the table view style as deletable
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell.EditingStyle { 
        return UITableViewCell.EditingStyle.delete 
    }
    
    
    // implement delete function
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            
            // delete the selected object from the managed
            // object context
            managedObjectContext.delete(fetchResults[indexPath.row])
            
            // delete the data from the city table
            birdList.removeBirdObject(item: indexPath.row)
            
            // remove it from the fetch results array
            let entity = fetchResults.remove(at: indexPath.row)
            
            //Method 1
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.endUpdates()
            
            do {
                // save the updated managed object context
                try managedObjectContext.save()
            } catch {
                
            }
            
            // reload the table after deleting a row
            tableView.reloadData()
        }
        
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let Sender = sender as? UITableViewCell {
            if let selectedIndex = self.tableView.indexPath(for: Sender as UITableViewCell) {
                let bird = birdList.getBirdObject(item: selectedIndex.row)
                
                if let destination = segue.destination as? DetailViewController {
                    destination.detailBird = bird;
                }
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
}
