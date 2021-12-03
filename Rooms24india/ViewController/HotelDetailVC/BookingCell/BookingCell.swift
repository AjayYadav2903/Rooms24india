//
//  BookingCell.swift
//  Rooms24india
//
//  Created by admin on 31/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class BookingCell: UITableViewCell {
    
    
    @IBOutlet weak var name : UITextField!
    @IBOutlet weak var phone : UITextField!
    @IBOutlet weak var email : UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
