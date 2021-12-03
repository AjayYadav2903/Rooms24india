//
//  DormitoryCollCell.swift
//  Rooms24india
//
//  Created by admin on 07/11/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Cosmos

class DormitoryCollCell: UICollectionViewCell {
   
    @IBOutlet weak var lblHotelName : UILabel!
    @IBOutlet weak var lblAddress : UILabel!
    @IBOutlet weak var lblPrice : UILabel!
    @IBOutlet weak var lblDiscount : UILabel!
    @IBOutlet weak var imgHotel : UIImageView!
    @IBOutlet weak var isWishList : UIButton!
    @IBOutlet weak var ratings : CosmosView!
    @IBOutlet weak var hotelRatings : UILabel!

}
