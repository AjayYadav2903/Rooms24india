//
//  AmenitiesCell.swift
//  Rooms24india
//
//  Created by admin on 22/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Cosmos

class AmenitiesCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblHotelName : UILabel!
    @IBOutlet weak var lblAddress : UILabel!
    @IBOutlet weak var lblPrice : UILabel!
    @IBOutlet weak var ratings : CosmosView!
    @IBOutlet weak var btnMapLocation : UIButton!

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension AmenitiesCell {

    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {

        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        collectionView.setContentOffset(collectionView.contentOffset, animated:false) // Stops collection view if it was scrolling.
        collectionView.reloadData()
    }

    var collectionViewOffset: CGFloat {
        set { collectionView.contentOffset.x = newValue }
        get { return collectionView.contentOffset.x }
    }
}

