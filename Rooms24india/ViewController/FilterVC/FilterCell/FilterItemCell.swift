//
//  FilterItemCell.swift
//  VSSHR
//
//  Created by admin on 28/09/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class FilterItemCell: UITableViewCell {

    @IBOutlet weak var lblItem : UILabel!
    @IBOutlet weak var vwBoderLine : UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
