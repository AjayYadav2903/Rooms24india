//
//  BestDealsCollCell.swift
//  Rooms24india
//
//  Created by admin on 21/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Cosmos

class BestDealsCollCell: UICollectionViewCell {

    @IBOutlet weak var btnBookNow : UIButton!
    @IBOutlet weak var lblTripName : UILabel!

    @IBOutlet weak var imgHotel : UIImageView!
    @IBOutlet weak var isWishList : UIButton!
    @IBOutlet weak var ratings : CosmosView!
}
