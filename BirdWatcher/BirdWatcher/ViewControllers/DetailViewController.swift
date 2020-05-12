//
//  DetailViewController.swift
//  BirdWatcher
//
//  Created by Alexandra Plukis on 3/22/20.
//  Copyright © 2020 Alexandra Plukis. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var birdName: UILabel!
    @IBOutlet weak var birdLog: UITextView!
    @IBOutlet weak var birdDate: UITextView!
    @IBOutlet weak var birdImage: UIImageView!
    
    var detailBird = Bird()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setToolbarHidden(true, animated: false)
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        addBirdInfo()

        // Do any additional setup after loading the view.
    }
    
    
    func addBirdInfo() {
        birdLog.text = detailBird.birdDesc
        birdName.text = detailBird.birdName
        
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .long
        
        // get the date time String from the date object
        birdDate.text = formatter.string(from: detailBird.birdDate! as Date) 
        birdImage.image = UIImage(data: detailBird.birdPicture! as Data)
        birdImage.contentMode = .scaleAspectFit
    }

}
