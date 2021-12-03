//
//  View.swift
//  Rooms24india
//
//  Created by admin on 21/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class View: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()

        self.roundCorners(corners: [.topLeft, .topRight], radius: 20)
    }
}

class TopViewNav: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()

        self.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 0)
    }
}

class ButtonCustom: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()

        self.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 30)
    }
}
