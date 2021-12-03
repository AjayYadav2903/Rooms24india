//
//  PricingCell.swift
//  Rooms24india
//
//  Created by admin on 31/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class PricingCell: UITableViewCell {

    @IBOutlet weak var lblCoupon : UILabel!
    @IBOutlet weak var lblAdditionalSaving : UILabel!
    @IBOutlet weak var lblFinalPrice : UILabel!
    @IBOutlet weak var lblDiscountPrice : UILabel!

    @IBOutlet weak var btnApply : UIButton!
    @IBOutlet weak var imgCouponApply : UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
