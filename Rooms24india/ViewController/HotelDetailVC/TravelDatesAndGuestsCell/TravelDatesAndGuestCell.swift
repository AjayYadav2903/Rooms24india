//
//  TravelDatesAndGuestCell.swift
//  Rooms24india
//
//  Created by admin on 31/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class TravelDatesAndGuestCell: UITableViewCell {

    @IBOutlet weak var btnOpenCalender : UIButton!
    @IBOutlet weak var imgCalender : UIImageView!
    @IBOutlet weak var lblDate : UILabel!
    @IBOutlet weak var lblTime : UILabel!

    @IBOutlet weak var btnRoomsPerCount : UIButton!
    @IBOutlet weak var imgRooms : UIImageView!
    @IBOutlet weak var lblRoomsCount : UILabel!
    @IBOutlet weak var lblPersonCount : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
