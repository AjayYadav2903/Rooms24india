//
//  ReviewDetailCell.swift
//  Rooms24india
//
//  Created by admin on 22/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Cosmos

class ReviewDetailCell: UITableViewCell {

    @IBOutlet weak var lblName : UILabel!
    @IBOutlet weak var imgUser : UIImageView!
    @IBOutlet weak var lblDate : UILabel!
    @IBOutlet weak var ratings : CosmosView!
    @IBOutlet weak var lblRatingDecs : UILabel!
    @IBOutlet weak var lblDesciption : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
