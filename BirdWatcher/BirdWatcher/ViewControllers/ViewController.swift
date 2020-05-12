//
//  ViewController.swift
//  BirdWatcher
//
//  Created by Alexandra Plukis on 3/22/20.
//  Copyright © 2020 Alexandra Plukis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var fact: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setToolbarHidden(true, animated: false)
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
            navigationController?.overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        getFact() //reduce delay when getting fact for first time
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setToolbarHidden(true, animated: false)
         if #available(iOS 13.0, *) {
                   overrideUserInterfaceStyle = .light
                   navigationController?.overrideUserInterfaceStyle = .light
        } else {
                   // Fallback on earlier versions
        }
    }

    @IBAction func showFact(_ sender: Any) {
        let alert = UIAlertController(title: "Bird Fact", message: fact, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Thanks!", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
        getFact()
    }
    
    func getFact() {
        let session = URLSession.shared
        
        guard let url = URL(string: "https://some-random-api.ml/facts/bird") else { return }
        
        // create a task that recieves the JSON object from the api
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            if let error = error as NSError? {
                print("Error:")
                print(error)
                return
            }
            
            guard let httpResonse = response as? HTTPURLResponse else {
                // if not a HTTPURLResponse, then we had an error that we want to send to console
                print("unknown response! sowwy")
                return
            }
            
            guard (200...299).contains(httpResonse.statusCode) else {
                // http status is an error if code is not between 200 - 299! send to console
                print("http resonse code: \(httpResonse.statusCode)")
                return
            }
            
            guard let data = data else { return }
            
            // to be able to get the dictionary values of the damage relationships
            let json = try? JSONSerialization.jsonObject(with: data, options: [.mutableContainers])
            
            if let factDict = json as? [String: Any] {
                if let newFact = factDict[factDict.startIndex].value as? String {
                    // don't want to have a paragraph length fact
                    if (newFact.count > 500) {
                        self.getFact()
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self.fact = newFact
                    }
                }
            }
        })
        
        // resume the program out of the api request
        task.resume()
    }
}

