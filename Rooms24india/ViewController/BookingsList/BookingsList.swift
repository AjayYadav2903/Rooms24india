//
//  BookingsList.swift
//  Rooms24india
//
//  Created by admin on 23/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class BookingsList: Rooms24BaseVC {

    @IBOutlet weak var bookingsTbl : UITableView!

    var bookingsData : BookingListData?
    
    @IBOutlet weak var lblBookDate : UILabel!
    @IBOutlet weak var lblBookType : UILabel!
    @IBOutlet weak var lblChekIn : UILabel!
    @IBOutlet weak var lblChekOut : UILabel!
    @IBOutlet weak var lblAadults : UILabel!
    @IBOutlet weak var lblChild : UILabel!
    @IBOutlet weak var lblPayment : UILabel!
    @IBOutlet weak var detailView : UIView!
    var paginate = 1
    var perPage = 50
    var isLoading = false
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.startMonitoringInternet(backgroundColor:UIColor.gray, style: .cardView, textColor:UIColor.white, message:"please check your internet connection", remoteHostName: "")
        serverRequest()
    }
    
    
    func serverRequest()  {
        let url: String = "https://rooms24india.com/sh/api/v1/bookingList?paginate\(paginate)&perPage=\(perPage)"
        WebServices.getRequest(urlApiString: url) {[weak self] (json, message, status) in
            guard let owner = self else {return}
            if status == true {
                let welcome = try? JSONDecoder().decode(BookingListData.self, from: (json.rawData()))
                self?.bookingsData = welcome
                self?.bookingsTbl.reloadData()
                
            } else {
                print(message!)
            }
            
        }
    }
    @IBAction func btnActionBack(_ sender: UIButton) {
           self.navigationController?.popViewController(animated: true)
       }

}

extension BookingsList: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bookingsData?.data.bookingList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookingListTblCell", for: indexPath) as! BookingListTblCell
        let hotelDetail = bookingsData?.data.bookingList[indexPath.row]
        cell.imgHotel.kf.setImage(with: URL(string: hotelDetail?.hotelDetails.media[0].url ?? "")!)
        //cell.lblAddress.text = hotelDetail?.hotel.hotel_name
        cell.lblHotelName.text = hotelDetail?.hotelDetails.hotelName
        cell.lblPrice.text = "₹ \(hotelDetail!.hotelDetails.bookingPrice)"
        cell.ratings.rating = hotelDetail?.hotelDetails.rating ?? 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 320
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.detailView.isHidden = false
        let hotelDetail = bookingsData?.data.bookingList[indexPath.row]

        lblBookDate.text = "     Booking Date : \(hotelDetail?.createdAt ?? "")"
        if hotelDetail?.bookingType == 1 {
            lblBookType.text = "     Booking Type : 6 Hour Booking"
        }else if hotelDetail?.bookingType == 2 {
            lblBookType.text = "     Booking Type : 24 hour Booking"
            
        }else if hotelDetail?.bookingType == 3 {
            lblBookType.text = "     Booking Type : Fixed Booking"
        }
        
        lblChekIn.text = "     Check In : \(hotelDetail?.checkIn ?? "")"
        lblChekOut.text = "     Check Out : \(hotelDetail?.checkOut ?? "")"
        lblAadults.text = "     Adults : \(hotelDetail?.adults ?? 0)"
        lblChild.text = "     Children : \(hotelDetail?.child ?? 0)"
       // lblPayment.text = hotelDetail?.p
       // lblBookDate.text = hotelDetail?.createdAt

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.detailView.isHidden = true
    }
}
