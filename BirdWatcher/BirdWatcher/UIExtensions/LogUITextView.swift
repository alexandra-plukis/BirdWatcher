//
//  Log.swift
//  BirdWatcher
//
//  Created by Alexandra Plukis on 3/22/20.
//  Copyright © 2020 Alexandra Plukis. All rights reserved.
//

import UIKit

class Log: UITextView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        let color: UIColor = UIColor(white: 0.75, alpha: 1.0)
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = 0.5
    }
    
}
