//
//  BookingListTblCell.swift
//  Rooms24india
//
//  Created by admin on 24/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Cosmos

class BookingListTblCell: UITableViewCell {

    @IBOutlet weak var lblKmAway : UILabel!
    @IBOutlet weak var lblHotelName : UILabel!
    @IBOutlet weak var lblAddress : UILabel!
    @IBOutlet weak var lblPrice : UILabel!
    @IBOutlet weak var lblDiscount : UILabel!
    @IBOutlet weak var imgHotel : UIImageView!
    @IBOutlet weak var isWishList : UIButton!
    @IBOutlet weak var ratings : CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
