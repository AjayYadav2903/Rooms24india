//
//  FacilitiesCell.swift
//  Rooms24india
//
//  Created by admin on 31/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class FacilitiesCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblFacilities : UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension FacilitiesCell {

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
