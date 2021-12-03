//
//  WishListVC.swift
//  Rooms24india
//
//  Created by admin on 23/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class WishListVC: Rooms24BaseVC {

    @IBOutlet weak var wishTbl : UITableView!
    var bookingsData : WishListData?
    var paginate = 1
    var perPage = 50
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.startMonitoringInternet(backgroundColor:UIColor.gray, style: .cardView, textColor:UIColor.white, message:"please check your internet connection", remoteHostName: "")
        serverRequest()
    }
    func serverRequest()  {
        let url: String = "https://rooms24india.com/sh/api/v1/whishlist?paginate\(paginate)&perPage=\(perPage)"
        WebServices.getRequest(urlApiString: url) {[weak self] (json, message, status) in
            guard let owner = self else {return}
            if status == true {
                let welcome = try? JSONDecoder().decode(WishListData.self, from: (json.rawData()))
                self?.bookingsData = welcome
                self?.wishTbl.reloadData()
                if json["data"].count == 0 {
                    PopupConfirmCommon.showRequestPopup(strMgs: message!, strTitle: "WishList", acceptBlock: nil, rejectBlock: nil)

                }
                
            } else {
                PopupConfirmCommon.showRequestPopup(strMgs: message!, strTitle: "WishList", acceptBlock: nil, rejectBlock: nil)

                print(message!)
            }
            
        }
    }
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension WishListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bookingsData?.data.whishList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WishListTblCell", for: indexPath) as! WishListTblCell
        let hotelDetail = bookingsData?.data.whishList[indexPath.row]
        cell.imgHotel.kf.setImage(with: URL(string: hotelDetail?.media[0].url ?? "")!)
        cell.lblAddress.text = ""//hotelDetail?.hotel.hotelName
        cell.lblHotelName.text = hotelDetail?.hotelName
        cell.lblPrice.text = "₹ \(hotelDetail!.bookingPrice)"
        cell.ratings.rating = Double(hotelDetail?.hotelRatings ?? 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 320
    }
}
