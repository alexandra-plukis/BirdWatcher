//
//  BirdTableViewCell.swift
//  BirdWatcher
//
//  Created by Alexandra Plukis on 3/22/20.
//  Copyright © 2020 Alexandra Plukis. All rights reserved.
//

import UIKit

class BirdTableViewCell: UITableViewCell {
    
    @IBOutlet weak var birdName: UILabel!
    @IBOutlet weak var birdImage: UIImageView! {
        didSet {
            birdImage.layer.cornerRadius = birdImage.bounds.width / 2
            birdImage.clipsToBounds = true
            birdImage.contentMode = .scaleAspectFit
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        // making a yellow border around the pictures
        super.setSelected(selected, animated: animated)
        let yellow = UIColor(red: 244/255, green: 201/255, blue: 93/255, alpha: 1.0)
        birdImage.layer.borderWidth = 2.5
        birdImage.layer.borderColor = yellow.cgColor
    }
}
