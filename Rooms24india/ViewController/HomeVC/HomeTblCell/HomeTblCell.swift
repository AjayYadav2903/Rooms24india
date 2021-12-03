//
//  HomeTblCell.swift
//  Rooms24india
//
//  Created by admin on 20/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class HomeTblCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnHeader: UIButton!
    @IBOutlet weak var imgArrowRight: UIImageView!

    @IBOutlet weak var consBtnHeight: NSLayoutConstraint!
    @IBOutlet weak var btnSelectRoomType : UIButton!

//    @IBOutlet weak var imgRooms: UIImageView!
//    @IBOutlet weak var lblRoomName: UILabel!
//    @IBOutlet weak var lblPersonAllowed: UILabel!
//    @IBOutlet weak var lblPrice: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

extension HomeTblCell {

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
