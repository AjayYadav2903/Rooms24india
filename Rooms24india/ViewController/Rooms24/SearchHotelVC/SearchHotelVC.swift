//
//  SearchHotelVC.swift
//  Rooms24india
//
//  Created by admin on 21/09/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Alamofire
import ImageSlideshow

class SearchHotelVC: Rooms24BaseVC,FilterData {

    @IBOutlet weak var bookingsTbl : UITableView!
    @IBOutlet weak var btnFilter : UIButton!
    
    @IBOutlet weak var lblNoHotel : UILabel!


    var hotelData : DataClass?

    var searchHotels = ""
    var shareManager : Globals = Globals.sharedInstance
    var arrNearyou = [Bestdeal]()
    var paginate = 1
    var perPage = 20
    var isLoading = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.startMonitoringInternet(backgroundColor:UIColor.gray, style: .cardView, textColor:UIColor.white, message:"please check your internet connection", remoteHostName: "")
        serverRequest()
    }
    
    
    func serverRequest()  {
        isLoading = true

        if searchHotels == "nearyou" {
        searchHotels = self.shareManager.cityglobal
        }
        let para: Parameters = ["sreach":searchHotels]
        var apiHome = ""
        if (AccountInfo.shared.getToken()) == "" {
            apiHome = "home?paginate\(paginate)&perPage=\(perPage)"
        }else {
            apiHome = "userHome?paginate=\(paginate)&perPage=\(perPage)"
        }
        
        WebServices.postRequest(urlApiString: "https://rooms24india.com/sh/api/v1/\(apiHome)", paramters: para) { (json, message, status) in
            if status {

                let welcome = try? JSONDecoder().decode(Welcome.self, from: (json?.rawData())!)
                
                
                if welcome != nil {
                    for arr in welcome!.data.nearyou {
                        self.arrNearyou.append(arr)
                    }
                }
                self.isLoading = false

              //  self.hotelData = welcome?.data
               
                self.bookingsTbl.reloadData()
            
            } else{
               // KRProgressHUD.dismiss({
               //     PopupConfirmCommon.showRequestPopup(strMgs: message ?? "", strTitle: "ERROR")
              //  })
            }
        }
        
    }
    @IBAction func btnActionBack(_ sender: UIButton) {
           self.navigationController?.popViewController(animated: true)
       }
    
    @IBAction func btnActionFilter(_ sender: UIButton) {
        let filterVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "FilterVC") as! FilterVC
        filterVC.delegate = self
        self.navigationController?.pushViewController(filterVC, animated: false)
        
             
          }
    
    func filteredData(data : DataClass) {
        self.hotelData = nil
        self.hotelData = data
        self.bookingsTbl.reloadData()
    }

}

extension SearchHotelVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrNearyou.count == 0 || arrNearyou == nil {
            lblNoHotel.isHidden = false
        }else {
            lblNoHotel.isHidden = true
        }
        return arrNearyou.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
      //  if hotelData != nil {
            if indexPath.row == (arrNearyou.count - 1) && !isLoading   {
                self.paginate += 1
                serverRequest()
            }
      //  }
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchListTblCell", for: indexPath) as! SearchListTblCell
        
        let hotelDetail = arrNearyou[indexPath.row]
        if arrNearyou[indexPath.row].imgURL != "" {
            cell.imgHotel.kf.setImage(with: URL(string: arrNearyou[indexPath.row].imgURL ?? "")!)
        }
        cell.lblAddress.text = hotelDetail.hotelAddress
        cell.lblHotelName.text = hotelDetail.hotelName
        cell.lblPrice.text = "₹ \(hotelDetail.bookingPrice)"
        cell.lblDiscount.text = "₹ \(hotelDetail.discountPrice) OFF"

        cell.ratings.rating = hotelDetail.hotelRatings ?? 0
        if hotelDetail.isOnWhishList ?? false {
           // cell.isWishList.setImage(UIImage(named: "heartFillIcon"), for: .normal)
        }else {
           // cell.isWishList.setImage(UIImage(named: "heartIcon"), for: .normal)
        }

      //  cell.isWishList.accessibilityHint = hotelDetail?.hotelID
      //  cell.isWishList.tag = indexPath.row
     //   cell.isWishList.addTarget(self, action: #selector(serverRequestForWishList(sender:)), for: .touchUpInside)
        var arrFeatureImage:[String] = [""]
        if hotelDetail.media != nil {
            for images in hotelDetail.media {
                arrFeatureImage.append(images.url)
            }
        }        
        
        if arrFeatureImage.count > 0{
            var datasource:[KingfisherSource] = [KingfisherSource]()
            for img in arrFeatureImage {
                if img != "" {
                    datasource.append(KingfisherSource(urlString: img)!)
                }
            }
          //  cell.imgeSlide.slideshowInterval = 2.0
            cell.imgeSlide.pageIndicatorPosition = .init(horizontal: .center, vertical: .bottom)
            cell.imgeSlide.contentScaleMode = UIView.ContentMode.scaleAspectFill
//            let pageControl = UIPageControl()
//            pageControl.currentPageIndicatorTintColor = UIColor(hexString: "#EC7700")
//            pageControl.pageIndicatorTintColor = UIColor(hexString: "#A9A9A9")
//            cell.imgeSlide.pageIndicator = pageControl
            cell.imgeSlide.activityIndicator = DefaultActivityIndicator()
            cell.imgeSlide.currentPageChanged = { [unowned self] page in
                //            print("current page:", page)
            }
            cell.vwLine.createDottedLine(width: 1, color: UIColor(hexString: "#EC7700").cgColor)
            cell.imgeSlide.setImageInputs(datasource)
        }

        return cell
    }
    
    func setSlideShowImg() {
        //setup slide

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 320
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let hotelDetailVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HotalDetailVC") as! HotalDetailVC
        let hotelDetail = arrNearyou[indexPath.row]
        hotelDetailVC.selectedHotelID = hotelDetail.hotelID
        hotelDetailVC.titleHeading = hotelDetail.hotelName 
        self.navigationController?.pushViewController(hotelDetailVC, animated: true)
    }
}

