//
//  RoundUIButton.swift
//  BirdWatcher
//
//  Created by Alexandra Plukis on 3/22/20.
//  Copyright © 2020 Alexandra Plukis. All rights reserved.
//

import UIKit

class RoundUIButton: UIButton {

    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 10
        //self.clipsToBounds = true
        self.backgroundColor = UIColor(red: (244/256), green: (201/256), blue: (93/256), alpha: 1.0)
        self.titleLabel?.font = UIFont(name: "Oxygen-Bold", size: 14)
        
    }
    
}
