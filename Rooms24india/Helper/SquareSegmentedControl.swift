//
//  SquareSegmentedControl.swift
//  AirVTing
//
//  Created by Thanh Gieng on 12/10/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
class SquareSegmentedControl: UISegmentedControl {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 4
    }
}
