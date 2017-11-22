//
//  RoundButton.swift
//  Calculator
//
//  Created by Maxime REVEL on 24/10/2017.
//  Copyright © 2017 Maxime REVEL. All rights reserved.
//

import Foundation
import UIKit

class RoundedButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.width/2
    }
}
