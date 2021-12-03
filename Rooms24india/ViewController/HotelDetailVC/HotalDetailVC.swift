//
//  HotalDetailVC.swift
//  Rooms24india
//
//  Created by admin on 22/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ImageSlideshow
import MapKit
import DatePickerDialog
import Alamofire
import SwiftyJSON
import KRProgressHUD
import Razorpay

//typealias Razorpay = RazorpayCheckout


class HotalDetailVC: Rooms24BaseVC,UIPickerViewDelegate,UIPickerViewDataSource {

    
    var selectedHotelID : String!
    let razorpayKey =  "rzp_test_AoVgfLcnn7vztX"
   // var razorpayObj : Razorpay? = nil
    var razorpayObj : RazorpayCheckout? = nil

    @IBOutlet weak var imgeSlide: ImageFullScreen!
    @IBOutlet weak var tblHotelDetail : UITableView!


    var hotelDetailData : HotelDetail?
     @IBOutlet weak var lblKmAway : UILabel!
     @IBOutlet weak var lblDiscount : UILabel!
     @IBOutlet weak var isWishList : UIButton!
    @IBOutlet weak var pickerPersonCount : UIPickerView!

    @IBOutlet weak var consHeightImgs : NSLayoutConstraint!
    var personCount = ["1","2","3","4","5" ,"6", "7", "8","9", "10"]

    @IBOutlet weak var pickerViewTitle : UIView!

    var pricingData = PricingModel()
    var hotelBookingSelection = [BtnStayHotelSelection]()
    var isPayAtHotel = 0
    
    @IBOutlet weak var btnPayNow : UIButton!
    @IBOutlet weak var btnPayLater : UIButton!

    var roomTypeSelection : [Bool]!
    
    var rowsWhichAreChecked = [NSIndexPath]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
    var arrFeatureImage:[String] = ["https://media.cntraveler.com/photos/5eaa67fbc4e7b60ed557b7f1/master/w_1400,h_939,c_limit/SMP_Rooms_04.2019_Ingals_1400x939_016.jpg","https://assets.simpleviewinc.com/simpleview/image/upload/c_fit,w_750,h_445/crm/santamonica/SMP_Rooms_Ingals_Apr_2019_A2A1594_Exclusive-1-_FAC93C6C-9DE8-455A-8F4D399DDD15FB07_58ea9606-93be-49de-b9e25b367f71833d.jpg","https://imagery.hoteltonight.com/production/attachments/files/6627882/original_normalized.jpg?fit=crop&dpr=1&fm=pjpg&q=50&w=375&h=315","https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcT8xUrl_xzwJ8rNi3-Qh3rJ7HMC6_0DTbdOHQ&usqp=CAU"]
    
//    var amenities = ["Free Wifi","Parking Facilities","Food","AC","T.V","Card Fecilities"]
//    var imgAmenities = ["wifi","parking","food","ac","tv","cardfacility"]

    var arrFacilities = [Facilities]()

    
    var bookingDate1 = String()
    var bookingDate2 = String()
    
    var bookingTime1 = String()
    var bookingTime2 = String()
    
    var bookingGuest = String()
    var bookingRoom = String()
    
    var txtName = String()
    var txtPhone = String()
    var txtEmail = String()
    
    
    var titleHeading = String()
    @IBOutlet weak var titleNav : UILabel!

    @IBOutlet var imgHotels : [UIImageView]!
    @IBOutlet weak var btnSeeAllImages : UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let room1 = RoomTypeSelection()
        room1.isSelected = false
        let room2 = RoomTypeSelection()
        room2.isSelected = false
        let room3 = RoomTypeSelection()
        room3.isSelected = false
        roomTypeSelection = [false,false,false]

        
        for img in imgHotels {
            img.alpha = 0.05
        }
        var hotelSelection1 = BtnStayHotelSelection()
        hotelSelection1.isSelected = false
        var hotelSelection2 = BtnStayHotelSelection()
        hotelSelection2.isSelected = false
        var hotelSelection3 = BtnStayHotelSelection()
        hotelSelection3.isSelected = false
        hotelBookingSelection.append(hotelSelection1)
        hotelBookingSelection.append(hotelSelection2)
        hotelBookingSelection.append(hotelSelection3)

        self.titleNav.text = titleHeading
        consHeightImgs.constant = (self.view.frame.size.height/3) - 100
        //self.startMonitoringInternet(backgroundColor:UIColor.gray, style: .cardView, textColor:UIColor.white, message:"please check your internet connection", remoteHostName: "")

       // let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(HotalDetailVC.didTapImage))
       // imgeSlide.addGestureRecognizer(gestureRecognizer)
        
        serverRequest()
        pickerPersonCount.tintColor = UIColor.lightGray
              pickerPersonCount.isHidden = true
        pickerViewTitle.isHidden = true
    }
    
    func serverRequest()  {
        //292b8a2c-e5ec-11ea-94b9-e8d0fcec03e2
        let url: String = "https://rooms24india.com/sh/api/v1/hoteldetails/" + "\(selectedHotelID ?? "")"
        WebServices.getRequest(urlApiString: url) {[weak self] (json, message, status) in
            guard let owner = self else {return}
            if status == true {
                let welcome = try? JSONDecoder().decode(HotelDetail.self, from: (json.rawData()))
                self?.hotelDetailData = welcome
                
                self?.arrFeatureImage = []
                if self?.hotelDetailData != nil {
                    for arr in 0..<self!.hotelDetailData!.data.media.count {
                        if self?.hotelDetailData!.data.media[arr].url != "" {
                            if arr < 6 {
                                self!.imgHotels[arr].alpha = 1.0
                                self!.imgHotels[arr].kf.setImage(with: URL(string: self?.hotelDetailData!.data.media[arr].url ?? "")!)
                            }
                        }
                        self?.arrFeatureImage.append(self?.hotelDetailData?.data.media[arr].url ?? "")
                    }
                    self?.tblHotelDetail.reloadData()
//                    for arr in 0..<self!.hotelDetailData!.data.facilities.count {
//                        if self!.hotelDetailData!.data.facilities[arr].facility_name == "Pay at Hotel" {
//                            self?.isPayAtHotel = true
//                        }
//                    }
//
//                    if self?.isPayAtHotel ?? false {
//                        self?.btnPayNow.isHidden = true
//                    }
                    
                    
                    //self?.setSlideShowImg()
                    if self!.hotelDetailData!.data.media.count > 6 {
                        self?.btnSeeAllImages.setTitle("+ \(self!.hotelDetailData!.data.media.count - 6) images", for: .normal)
                    }else {
                        self?.btnSeeAllImages.setTitle("", for: .normal)
                    }
                }

            } else {
                print(message!)
            }
        }
    }
    
    func setSlideShowImg() {
        //setup slide
        if self.arrFeatureImage.count > 0{
            var datasource:[KingfisherSource] = [KingfisherSource]()
            for img in self.arrFeatureImage {
                datasource.append(KingfisherSource(urlString: img)!)
            }
            
            self.imgeSlide.slideshowInterval = 2.0
            self.imgeSlide.pageIndicatorPosition = .init(horizontal: .center, vertical: .bottom)
            self.imgeSlide.contentScaleMode = UIView.ContentMode.scaleAspectFill
            let pageControl = UIPageControl()
            pageControl.currentPageIndicatorTintColor = UIColor(hexString: "#EC7700")
            pageControl.pageIndicatorTintColor = UIColor(hexString: "#A9A9A9")
            self.imgeSlide.pageIndicator = pageControl
            self.imgeSlide.activityIndicator = DefaultActivityIndicator()
            self.imgeSlide.currentPageChanged = { [unowned self] page in
                //            print("current page:", page)
            }
            self.imgeSlide.setImageInputs(datasource)
        }
    }
    
    @objc func didTapImage() {
        imgeSlide.presentFullScreenImageController(from: self)
    }
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnActionShowAllImages(_ sender: UIButton) {
      showImages(selectedIndex :  5)

    }
    
    @IBAction func btnActionShowImg1(_ sender: UIButton) {
      showImages(selectedIndex :  0)
     }
    @IBAction func btnActionShowImg2(_ sender: UIButton) {
      showImages(selectedIndex :  1)
    }
    @IBAction func btnActionShowImg3(_ sender: UIButton) {
     showImages(selectedIndex :  2)
    }
    @IBAction func btnActionShowImg4(_ sender: UIButton) {
      showImages(selectedIndex :  3)
    }
    @IBAction func btnActionShowImg5(_ sender: UIButton) {
      showImages(selectedIndex :  4)
    }
    
    func showImages(selectedIndex :  Int)  {
        let showAllImg = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "ShowAllImagesOnZDetails") as! ShowAllImagesOnZDetails
        showAllImg.arrFeatureImage = arrFeatureImage
        showAllImg.selectedIndex = selectedIndex
        self.navigationController?.pushViewController(showAllImg, animated: true)

    }
    
    
    
    @IBAction func btnActionFaviourite(_ sender: UIButton) {
        
    }
    @IBAction func btnActionBookNow(_ sender: UIButton) {
        self.view.endEditing(true)
        isPayAtHotel = 0
//        let loginStoryBoard = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "BookingFormVC") as! BookingFormVC
//        loginStoryBoard.hotelId = ""
//        self.navigationController?.pushViewController(loginStoryBoard, animated: true)
        if AccountInfo.shared.getToken() != "" {
            self.serverRequestBooking()
        }else {
            let alert = UIAlertController(title: title, message: "Please login", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                let loginStoryBoard = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                self.navigationController?.pushViewController(loginStoryBoard, animated: true)
            }))
            present(alert, animated: true, completion: nil)

        }
    }
    
      @IBAction func btnActionPayonline(_ sender: UIButton) {
            self.view.endEditing(true)
        isPayAtHotel = 1
        if AccountInfo.shared.getToken() != "" {
            serverRequestBookingPayOnline()
      }else {
          let alert = UIAlertController(title: title, message: "Please login", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
              let loginStoryBoard = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
              self.navigationController?.pushViewController(loginStoryBoard, animated: true)
          }))
        present(alert, animated: true, completion: nil)
      }
    }
}

extension HotalDetailVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        if collectionView.tag == 0 {
            return self.hotelDetailData?.data.amenities.count ?? 0
        }else if collectionView.tag == 105 {
            return 3//self.hotelDetailData?.data.amenities.count ?? 0
        }else if collectionView.tag == 102 {
            return self.hotelDetailData?.data.facilities.count ?? 0
        }
        
        return  0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            let amentiesData = self.hotelDetailData?.data.amenities[indexPath.row]

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AmeitiesCollCell", for: indexPath) as! AmeitiesCollCell
           // if amentiesData != nil {
            cell.lblAmeiti.text = amentiesData?.amenitiesName
               // cell.imgAmeiti.image = UIImage(named: amentiesData[indexPath.item])
            cell.imgAmeiti.kf.setImage(with: URL(string: amentiesData!.amenitiesImg ?? "")!)
         //   }

            return cell
        }
        if collectionView.tag == 105 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NearYouCollCell", for: indexPath) as! NearYouCollCell
           
            let roomsData = self.hotelDetailData?.data.rooms[indexPath.item]
            if roomsData != nil {
                cell.imgHotel.alpha = 0.3
    //            let hotelDetail = hotelData?.nearyou[indexPath.row]
                if indexPath.row == self.hotelDetailData?.data.rooms.count ?? 0 || indexPath.row > self.hotelDetailData?.data.rooms.count ?? 0 {
                   return cell
                }
                if self.hotelDetailData?.data.rooms[indexPath.item].media.count ?? 0 > 0 {
                    if self.hotelDetailData?.data.rooms.count ?? 0 > 0 && self.hotelDetailData?.data.rooms[indexPath.item].media[0].url != nil {
                        cell.imgHotel.alpha = 1
                        if self.hotelDetailData?.data.rooms[indexPath.item].media[0].url != "" {
                            cell.imgHotel.kf.setImage(with: URL(string: self.hotelDetailData?.data.rooms[indexPath.item].media[0].url ?? "")!)
                        }
                    }
                }
                

                cell.lblAddress.text = "Total Person Allowed \(String(describing: roomsData!.numberOfAllowedPerson))"
                cell.lblHotelName.text = roomsData?.roomTitle
                cell.lblPrice.text = "₹ \(String(describing: roomsData!.price - roomsData!.discount))"
            }
            
      
//            cell.lblDiscount.text = "₹ \(hotelDetail!.discountPrice) OFF"
//
//            cell.hotelRatings.isHidden = true
//            if roomTypeSelection[indexPath.row] {
//                cell.isWishList.setImage(UIImage(named: "rightTickBlue"), for: .normal)
//            }else {
//                cell.isWishList.setImage(UIImage(named: "untickcoupon"), for: .normal)
//            }
//            cell.isWishList.accessibilityHint = hotelDetail?.hotelID
//            cell.isWishList.tag = indexPath.row
//            cell.isWishList.addTarget(self, action: #selector(serverRequestForWishList(sender:)), for: .touchUpInside)
//
            return cell
        }
        if collectionView.tag == 102 {
            let amentiesData = self.hotelDetailData?.data.facilities[indexPath.row]

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FacilitiesCollCell", for: indexPath) as! FacilitiesCollCell
            cell.lblAmeiti.text = amentiesData?.facility_name

            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = UIColor.red

        return cell
    }

    @objc func selectRoomType(sender : UIButton)  {
        var dataArr = NSMutableArray()
        dataArr.add("Classic")
        dataArr.add("Delux")
        dataArr.add("Super Delux")
        PopupSingleSelection.showRequestPopup(dataArr:dataArr , strMgs: "a", placeholder: "", strTitle: "Select Room Type", strActionTitle: "", isShowCloseButton: true, isRemoveAllSubview: false) {
             let indexPath = NSIndexPath(row: 1, section: 0)
             self.tblHotelDetail.reloadRows(at: [(indexPath as IndexPath)], with: UITableView.RowAnimation.none)
        } rejectBlock: {
            
        }

        
     //   PopupSingleSelection.showRequestPopup(dataArr: dataArr, strMgs: "aa", placeholder: "ss", strTitle: "Select Room Type")

    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 105 {
            let cell:NearYouCollCell = collectionView.cellForItem(at: indexPath) as! NearYouCollCell
            // cross checking for checked rows
            if(rowsWhichAreChecked.contains(indexPath as NSIndexPath) == false){
                cell.isWishList.setImage(UIImage(named: "checkwhitetick"), for: .normal)
                rowsWhichAreChecked.append(indexPath as NSIndexPath)
            }else{
                cell.isWishList.setImage(UIImage(named: "untickcoupon"), for: .normal)
                // remove the indexPath from rowsWhichAreCheckedArray
                if let checkedItemIndex = rowsWhichAreChecked.firstIndex(of: indexPath as NSIndexPath){
                    rowsWhichAreChecked.remove(at: checkedItemIndex)
                }
            }
        }
    
 
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 102 {
            return CGSize(width: (collectionView.frame.size.width/3) + 50, height: (collectionView.frame.size.height/2) - 20)
        }

        
        if collectionView.tag == 105 {
            return CGSize(width: 180, height: 210)
        }
        

        return CGSize(width: (collectionView.frame.size.width/3), height: (collectionView.frame.size.height/2) - 15)
    }
}

extension HotalDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AmenitiesCell", for: indexPath) as! AmenitiesCell
            let amentiesData = self.hotelDetailData?.data
            if amentiesData != nil {
                cell.lblAddress.text = "\(amentiesData!.address.country) \(amentiesData!.address.city)"
                cell.lblPrice.text =  "₹\(amentiesData!.bookingPrice)"
            }
            cell.lblHotelName.text = amentiesData?.hotelName
            cell.ratings.rating = amentiesData?.rating ?? 0
            cell.btnMapLocation.addTarget(self, action: #selector(getDirections(loc1:loc2:)), for: .touchUpInside)
            cell.collectionView.tag = 0
            
            return cell
        }else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTblCell", for: indexPath) as! HomeTblCell
            cell.btnSelectRoomType.addTarget(self, action: #selector(selectRoomType(sender:)), for: .touchUpInside)
            cell.btnSelectRoomType.setTitle(appDelegate.selectedRoomType, for: .normal)

            
            
            cell.collectionView.tag = 105
            return cell

        }
        
        
        else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TravelDatesAndGuestCell", for: indexPath) as! TravelDatesAndGuestCell
            cell.btnOpenCalender.addTarget(self, action: #selector(clickOnOpenCalender), for: .touchUpInside)
            cell.btnRoomsPerCount.addTarget(self, action: #selector(clickForSelectRoomsAndCount), for: .touchUpInside)
            if self.bookingDate1 == "" {
                cell.lblDate.text = "Select CheckIN CheckOUT "

            }else {
                cell.lblDate.text = self.bookingDate1 + " to " + self.bookingDate2

            }
           
            if self.bookingDate1 == "" {
                cell.lblTime.text = "Time"

            }else {
                cell.lblDate.text = self.bookingDate1 + " to " + self.bookingDate2
                cell.lblTime.text = self.bookingTime1 + " to " + self.bookingTime2

            }
            
            if self.bookingRoom == "" {
                cell.lblRoomsCount.text = "Select Rooms"
            }else {
              cell.lblRoomsCount.text = self.bookingRoom + " " + "Rooms"
            }
            
            if self.bookingGuest == "" {
                cell.lblPersonCount.text = "Select Guest"

            }else {
                cell.lblPersonCount.text = self.bookingGuest + " " + "Guest"
            }

            return cell

        }else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CheckInOutSelectionCell", for: indexPath) as! CheckInOutSelectionCell

            cell.btn24stay.tag = 0
            cell.btnFixedstay.tag = 1
            cell.btn6hrstay.tag = 2
            
            cell.btn24stay.addTarget(self, action: #selector(btnSelectionHotelBookingStay(sender:)), for: .touchUpInside)
            cell.btn6hrstay.addTarget(self, action: #selector(btnSelectionHotelBookingStay(sender:)), for: .touchUpInside)
            cell.btnFixedstay.addTarget(self, action: #selector(btnSelectionHotelBookingStay(sender:)), for: .touchUpInside)

            
           print("(hotelBookingSelection[0]).isSelected\((hotelBookingSelection[0]).isSelected)")
            print("(hotelBookingSelection[1]).isSelected\((hotelBookingSelection[1]).isSelected)")
            print("(hotelBookingSelection[2]).isSelected\((hotelBookingSelection[2]).isSelected)")

            if (hotelBookingSelection[0]).isSelected{
                let icon = UIImage(named: "rightTickBlue")!
                cell.btn24stay.imageView?.contentMode = .scaleAspectFit
                cell.btn24stay.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 30)
                cell.btn24stay.setImage(icon, for: .normal)
                cell.btnFixedstay.setImage(nil, for: .normal)
                cell.btnFixedstay.setTitleColor(UIColor.blue, for: .normal)
                
                cell.btn6hrstay.setImage(nil, for: .normal)
                cell.btn6hrstay.setTitleColor(UIColor.blue, for: .normal)
                (hotelBookingSelection[1]).isSelected = false
                (hotelBookingSelection[2]).isSelected = false
                return cell
            }else {
                
                cell.btnFixedstay.setImage(nil, for: .normal)
                cell.btnFixedstay.setTitleColor(UIColor.blue, for: .normal)
                
                cell.btn24stay.setImage(nil, for: .normal)
                cell.btn24stay.setTitleColor(UIColor.blue, for: .normal)
                
                cell.btn6hrstay.setImage(nil, for: .normal)
                cell.btn6hrstay.setTitleColor(UIColor.blue, for: .normal)
                
            }
            
            
            if (hotelBookingSelection[1]).isSelected {
                let icon = UIImage(named: "rightTickBlue")!
                cell.btnFixedstay.imageView?.contentMode = .scaleAspectFit
                cell.btnFixedstay.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 30)
                cell.btnFixedstay.setImage(icon, for: .normal)
               // cell.btn24stay.setTitleColor(UIColor.black, for: .normal)
               // cell.btn6hrstay.setTitleColor(UIColor.black, for: .normal)
                
                cell.btn24stay.setImage(nil, for: .normal)
                cell.btn24stay.setTitleColor(UIColor.blue, for: .normal)
                
                cell.btn6hrstay.setImage(nil, for: .normal)
                cell.btn6hrstay.setTitleColor(UIColor.blue, for: .normal)

                (hotelBookingSelection[0]).isSelected = false
                (hotelBookingSelection[2]).isSelected = false
                return cell
            }else {
                cell.btnFixedstay.setImage(nil, for: .normal)
                cell.btnFixedstay.setTitleColor(UIColor.blue, for: .normal)
                
                cell.btn24stay.setImage(nil, for: .normal)
                cell.btn24stay.setTitleColor(UIColor.blue, for: .normal)
                
                cell.btn6hrstay.setImage(nil, for: .normal)
                cell.btn6hrstay.setTitleColor(UIColor.blue, for: .normal)

                
            }
            if (hotelBookingSelection[2]).isSelected {
                let icon = UIImage(named: "rightTickBlue")!
                cell.btn6hrstay.imageView?.contentMode = .scaleAspectFit
                cell.btn6hrstay.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 30)
                cell.btn6hrstay.setImage(icon, for: .normal)
               // cell.btnFixedstay.setTitleColor(UIColor.black, for: .normal)
               // cell.btn24stay.setTitleColor(UIColor.black, for: .normal)
                cell.btnFixedstay.setImage(nil, for: .normal)
                cell.btnFixedstay.setTitleColor(UIColor.blue, for: .normal)
                
                cell.btn24stay.setImage(nil, for: .normal)
                cell.btn24stay.setTitleColor(UIColor.blue, for: .normal)
                

                (hotelBookingSelection[0]).isSelected = false
                (hotelBookingSelection[1]).isSelected = false
                return cell
            }else {
                cell.btnFixedstay.setImage(nil, for: .normal)
                cell.btnFixedstay.setTitleColor(UIColor.blue, for: .normal)
                
                cell.btn24stay.setImage(nil, for: .normal)
                cell.btn24stay.setTitleColor(UIColor.blue, for: .normal)
                
                cell.btn6hrstay.setImage(nil, for: .normal)
                cell.btn6hrstay.setTitleColor(UIColor.blue, for: .normal)
            }
        
            return cell

            
        }else if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FacilitiesCell", for: indexPath) as! FacilitiesCell
            cell.collectionView.tag = 102
            return cell

        }
        else if indexPath.row == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewRatingCell", for: indexPath) as! ReviewRatingCell
            return cell

        }
        else if indexPath.row == 6 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RulesPolicyCell", for: indexPath) as! RulesPolicyCell
            return cell

        }
        else if indexPath.row == 7 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookingCell", for: indexPath) as! BookingCell
            txtName = cell.name.text!
            txtEmail = cell.email.text!
            txtPhone = cell.phone.text!
            if cell.name.text == "" {
                cell.name.text = AccountInfo.shared.loadUserModel().username
                if AccountInfo.shared.loadUserModel().username == "" {
                    cell.name.text =  AccountInfo.shared.loadUserModel().displayName
                }
                txtName = cell.name.text!
            }
            if cell.email.text == "" {
                cell.email.text = AccountInfo.shared.loadUserModel().email
                txtEmail = cell.email.text!
            }
            if cell.phone.text == "" {
                cell.phone.text = AccountInfo.shared.loadUserModel().phoneNumber
                txtPhone = cell.phone.text!
            }
            cell.name.accessibilityValue = "name"
            cell.email.accessibilityValue = "email"
            cell.phone.accessibilityValue = "phone"
            cell.name.delegate = self
            cell.email.delegate = self
            cell.phone.delegate = self
            
            return cell

        }
        else if indexPath.row == 8 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PricingCell", for: indexPath) as! PricingCell
            let amentiesData = self.hotelDetailData?.data
            if amentiesData != nil {
                cell.lblAdditionalSaving.text =  "₹\(String(describing: amentiesData?.discount ?? 0))"
                let totalDiscount = (amentiesData!.bookingPrice - 500)
                cell.btnApply.addTarget(self, action: #selector(btnApplyCoupon(sender:)), for: .touchUpInside)
                if pricingData.isCoupnSelect {
                    cell.imgCouponApply.image = UIImage(named: "tickcoupon")
                    cell.lblFinalPrice.text =  "₹\(totalDiscount)"
                    cell.lblCoupon.text =  "-\(500)"
                    
                }else {
                    cell.imgCouponApply.image = UIImage(named: "untickcoupon")
                    cell.lblFinalPrice.text =  "₹\(amentiesData!.bookingPrice)"
                    cell.lblCoupon.text =  "-\(500)"
                }
            }
            return cell
            
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: "TravelDatesAndGuestCell", for: indexPath) as! TravelDatesAndGuestCell
        return cell
    }
    
    @objc func btnSelectionHotelBookingStay(sender : UIButton)  {
        if (hotelBookingSelection[sender.tag]).isSelected {
           
            (hotelBookingSelection[0]).isSelected = false
            (hotelBookingSelection[1]).isSelected = false
            (hotelBookingSelection[2]).isSelected = false
        
        }else {
            if sender.tag == 0 {
                (hotelBookingSelection[0]).isSelected = true
                (hotelBookingSelection[1]).isSelected = false
                (hotelBookingSelection[2]).isSelected = false
            }
            if sender.tag == 1 {
                (hotelBookingSelection[0]).isSelected = false
                (hotelBookingSelection[1]).isSelected = true
                (hotelBookingSelection[2]).isSelected = false
            }
            if sender.tag == 2 {
                (hotelBookingSelection[0]).isSelected = false
                (hotelBookingSelection[1]).isSelected = false
                (hotelBookingSelection[2]).isSelected = true
            }
        }
            
        
       let indexPath = NSIndexPath(row: 3, section: 0)
        self.tblHotelDetail.reloadRows(at: [(indexPath as IndexPath)], with: UITableView.RowAnimation.none)
      }
    
    @objc func btnApplyCoupon(sender : UIButton)  {
        if !pricingData.isCoupnSelect {
            pricingData.isCoupnSelect = true
        }else {
            pricingData.isCoupnSelect = false
        }
        let indexPath = NSIndexPath(row: 8, section: 0)
        self.tblHotelDetail.reloadRows(at: [(indexPath as IndexPath)], with: UITableView.RowAnimation.top)
    }
    
    @objc func clickOnOpenCalender()  {
        
        if (self.hotelBookingSelection[1]).isSelected {
            DatePickerDialog().show("Check IN", doneButtonTitle: "done", cancelButtonTitle: "cancel", datePickerMode: .date) { (date) -> Void in
                 if let dt = date {
                    if dt.isPast {
                        PopupConfirmCommon.showRequestPopup(strMgs: "Ohh!! Can not book in past date", strTitle: "Booking", acceptBlock: nil, rejectBlock: nil)

                        return
                    }
              let formatter = DateFormatter()
                         formatter.dateFormat = "dd-MM-yyyy"
                       let formatter1 = DateFormatter()
                       formatter1.dateFormat = "hh:mm a"
                       self.bookingTime1 = "12PM"
                       self.bookingDate1 = formatter.string(from: dt)
                       self.tblHotelDetail.reloadData()
                    
                    let date1 = date!.addingTimeInterval(23 * 60 * 60)
                    print(date1)
                    let formatterr = DateFormatter()
                    formatterr.dateFormat = "dd-MM-yyyy"
                    let formatter2 = DateFormatter()
                    formatter2.dateFormat = "hh:mm a"
                    self.bookingDate2 =  formatterr.string(from: date1)
                    self.bookingTime2 = "11AM"
                    self.tblHotelDetail.reloadData()
                }
            }
          return
        }
        
     DatePickerDialog().show("Check IN", doneButtonTitle: "done", cancelButtonTitle: "cancel", datePickerMode: .dateAndTime) { (date) -> Void in
            print(date)
          if let dt = date {
            if dt.isPast {
                PopupConfirmCommon.showRequestPopup(strMgs: "Ohh!! Can not book in past date", strTitle: "Booking", acceptBlock: nil, rejectBlock: nil)

                return
            }
              let formatter = DateFormatter()
              formatter.dateFormat = "dd-MM-yyyy"
            let formatter1 = DateFormatter()
            formatter1.dateFormat = "hh:mm a"
            self.bookingTime1 = formatter1.string(from: dt)
            self.bookingDate1 = formatter.string(from: dt)
            self.tblHotelDetail.reloadData()
            
            
            
            if (self.hotelBookingSelection[0]).isSelected {
                
                
                
                let date1 = date!.addingTimeInterval(24 * 60 * 60)
                print(date1)
                let formatterr = DateFormatter()
                formatterr.dateFormat = "dd-MM-yyyy"
                let formatter2 = DateFormatter()
                formatter2.dateFormat = "hh:mm a"
                self.bookingDate2 = formatterr.string(from: date1)
                self.bookingTime2 = formatter2.string(from: date1)
                self.tblHotelDetail.reloadData()
               return
            }

            
            if (self.hotelBookingSelection[2]).isSelected {
                let date1 = date!.addingTimeInterval(6 * 60 * 60)
                print(date1)
                let formatterr = DateFormatter()
                formatterr.dateFormat = "dd-MM-yyyy"
                let formatter2 = DateFormatter()
                formatter2.dateFormat = "hh:mm a"
                self.bookingDate2 = formatterr.string(from: date1)
                self.bookingTime2 = formatter2.string(from: date1)
                self.tblHotelDetail.reloadData()
                return
            }
            self.openDatePicker()
          }
      }
    }
    
    func openDatePicker() {
        
       if (self.hotelBookingSelection[1]).isSelected {
            DatePickerDialog().show("Check OUT", doneButtonTitle: "done", cancelButtonTitle: "cancel", datePickerMode: .date) { (date) -> Void in
                if let dt = date {
                    if dt.isPast {
                        PopupConfirmCommon.showRequestPopup(strMgs: "Ohh!! Can not book in past date", strTitle: "Booking", acceptBlock: nil, rejectBlock: nil)

                        return
                    }
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd-MM-yyyy"
                    self.bookingDate2 = formatter.string(from: dt)
                    let formatter1 = DateFormatter()
                    formatter1.dateFormat = "hh:mm a"
                    self.bookingTime2 = formatter1.string(from: dt)
                    self.tblHotelDetail.reloadData()
                    
                    // self.birthdayField.text = formatter.string(from: dt)
                    
                }
            }
       }else {
        DatePickerDialog().show("Check OUT", doneButtonTitle: "done", cancelButtonTitle: "cancel", datePickerMode: .dateAndTime) { (date) -> Void in
            if let dt = date {
                if dt.isPast {
                    PopupConfirmCommon.showRequestPopup(strMgs: "Ohh!! Can not book in past date", strTitle: "Booking", acceptBlock: nil, rejectBlock: nil)

                    return
                }
                let formatter = DateFormatter()
                formatter.dateFormat = "dd-MM-yyyy"
                self.bookingDate2 = formatter.string(from: dt)
                let formatter1 = DateFormatter()
                formatter1.dateFormat = "hh:mm a"
                self.bookingTime2 = formatter1.string(from: dt)
                self.tblHotelDetail.reloadData()
                
                // self.birthdayField.text = formatter.string(from: dt)
                
            }
        }
        }
        
        
    }
    
      @objc func clickForSelectRoomsAndCount() {
        pickerPersonCount.isHidden = false
        pickerPersonCount.delegate = self
        pickerPersonCount.dataSource = self
        pickerViewTitle.isHidden = false
        }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
             return 2
         }
         
         func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return personCount.count
         }
         
         func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
          if component == 0 {
            bookingRoom = personCount[row]
              //btnAdult.setTitle(personCount[row], for: .normal)

          }else {
            bookingGuest = personCount[row]

              //btnChild.setTitle(personCount[row], for: .normal)

          }
             pickerView.isHidden = true
            pickerViewTitle.isHidden = true
            self.tblHotelDetail.reloadData()
         }
         
         func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
             let attributedString = NSAttributedString(string: personCount[row], attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
             return attributedString
         }
      
    @objc func getDirections(loc1: CLLocationCoordinate2D, loc2: CLLocationCoordinate2D) {
        let lat =  Double(self.hotelDetailData?.data.address.latitude ?? 0) 
        let long = Double(self.hotelDetailData?.data.address.longitude ?? 0) 

        let coordinateOne = CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly:lat)!, longitude: CLLocationDegrees(exactly: long)!)
                let coordinateTwo = CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly: 28.5904)!, longitude: CLLocationDegrees(exactly: 78.5718)!)
         let source = MKMapItem(placemark: MKPlacemark(coordinate: coordinateOne))
         source.name = "Your Location"
         let destination = MKMapItem(placemark: MKPlacemark(coordinate: coordinateTwo))
         destination.name = "Destination"
         MKMapItem.openMaps(with: [source, destination], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
      }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 100
        } else if indexPath.row == 1 {
            return 315
        }
        
        
        else if indexPath.row == 2 {
            return 150
        }else if indexPath.row == 3 {
            return 170
        }
        else if indexPath.row == 4 {
            return 140
        }
        else if indexPath.row == 5 {
            return 200
        }else if indexPath.row == 6 {
            return 360
        }else if indexPath.row == 7 {
            return 260
        }else if indexPath.row == 8 {
            return 320
        }
        return 280
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.isKind(of: AmenitiesCell.self) {
            let tableViewCell = cell as! AmenitiesCell
            tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
        }
        
        if cell.isKind(of: FacilitiesCell.self) {
            let tableViewCell = cell as! FacilitiesCell
            tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: 102)
        }
        
        
        if cell.isKind(of: HomeTblCell.self) {
            let tableViewCell = cell as! HomeTblCell
            tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: 105)
        }
        
        //tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? AmenitiesCell else { return }

              // storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    }
    
   
}

extension HotalDetailVC : UITextFieldDelegate {
    func serverRequestBooking()  {
        if bookingDate1 == "" {
                PopupConfirmCommon.showRequestPopup(strMgs: "Please select Check IN Check OUT time", strTitle: "Booking", acceptBlock: nil, rejectBlock: nil)
                return
        }
        
        if validateFields() {
            let str1 = bookingTime1.separate(withChar: " ") as NSArray
            let str2 = bookingTime1.separate(withChar: " ") as NSArray
            let strValue1 = str1[0] as! String
            let strValue2 = str2[0] as! String

            let dateString =  bookingDate1 + " " + strValue1
            let inputDateFormatter = DateFormatter()
            inputDateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
            let date = inputDateFormatter.date(from: dateString)

            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            let date1 =  outputDateFormatter.string(from: date!)

            let dateString2 = bookingDate2 + " " + strValue2
            let inputDateFormatter2 = DateFormatter()
            inputDateFormatter2.dateFormat = "dd/MM/yyyy HH:mm"
            let date2 = inputDateFormatter2.date(from: dateString2)

            let outputDateFormatter2 = DateFormatter()
            outputDateFormatter2.dateFormat = "yyyy-MM-dd HH:mm"
            let datel =  outputDateFormatter2.string(from: date2!)

            var roomType = String()

            if appDelegate.selectedRoomType == "Classic" {
                if self.hotelDetailData?.data.rooms.count ?? 0 > 0 {
                    roomType = self.hotelDetailData?.data.rooms[0].sid ?? ""
                }
            }else if appDelegate.selectedRoomType == "Delux"{
                if self.hotelDetailData?.data.rooms.count ?? 0 > 1{
                roomType = self.hotelDetailData?.data.rooms[1].sid ?? ""
                }
            }else {
                if self.hotelDetailData?.data.rooms.count ?? 0 > 2 {
                roomType = self.hotelDetailData?.data.rooms[2].sid ?? ""
                }
            }
            
            var bookingType = String()

            if (hotelBookingSelection[0]).isSelected {
                bookingType = "1"
            }else if (hotelBookingSelection[1]).isSelected {
                bookingType = "2"
            }else {
                bookingType = "3"
            }
            
            let para: Parameters = ["hotelId":selectedHotelID!,"name":txtName ?? "","phoneNumber":txtPhone ?? "","emailAddress":txtEmail ?? "","checkIn": date1 ,"checkOut":datel ,"adults":bookingGuest ?? "","child":bookingRoom ?? "","booking_type":bookingType,"payment":"\(isPayAtHotel)","room_type":roomType]
            
          //  let para: Parameters = ["hotelId":selectedHotelID!,"name":txtName ?? "","phoneNumber":txtPhone ?? "","emailAddress":txtEmail ?? "","checkIn": date1 ,"checkOut":datel ,"adults":bookingGuest ?? "","child":bookingRoom ?? ""]

            WebServices.postRequest(urlApiString: "https://rooms24india.com/sh/api/v1/hotel_booking", paramters: para) { (json, message, status) in
                if status {
                    KRProgressHUD.dismiss({
                        let str = "Your booking has been confirmed from \(self.bookingDate1), \(self.bookingTime1) to \(self.bookingDate2), \(self.bookingTime2) at \(self.titleHeading)."
                PopUpConfirmCommon2.showRequestPopup(strMgs: str, strTitle: "Congratulations!", strActionTitle: "Ok", isShowCloseButton: true, isRemoveAllSubview: false, acceptBlock: {

                  let loginStoryBoard = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "RatingVC") as! RatingVC
                    self.navigationController?.pushViewController(loginStoryBoard, animated: true)

                })
                    })
                } else{
                    KRProgressHUD.dismiss({
                        PopupConfirmCommon.showRequestPopup(strMgs: message ?? "", strTitle: "ERROR")
                    })
                }
            }
        }else {

        }
    }
    
    
    func serverRequestBookingPayOnline()  {
        if AccountInfo.shared.getToken() != "" {
            if bookingDate1 == "" {
                    PopupConfirmCommon.showRequestPopup(strMgs: "Please select Check IN Check OUT time", strTitle: "Booking", acceptBlock: nil, rejectBlock: nil)
                    return
            }
            
            if validateFields() {
                openRazorpayCheckout()
            }else {

            }
        }else {
            let alert = UIAlertController(title: title, message: "Please login", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                let loginStoryBoard = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                self.navigationController?.pushViewController(loginStoryBoard, animated: true)
            }))
            present(alert, animated: true, completion: nil)

        }       
    }
    
    
    func checkout()  {
        
        let str1 = bookingTime1.separate(withChar: " ") as NSArray
        let str2 = bookingTime1.separate(withChar: " ") as NSArray
        let strValue1 = str1[0] as! String
        let strValue2 = str2[0] as! String
        
        let dateString =  bookingDate1 + " " + strValue1
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "dd/MM/yyyy HH:mm a"
        let date = inputDateFormatter.date(from: dateString)

        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "yyyy-MM-dd HH:mm a"
        let date1 =  outputDateFormatter.string(from: date!)

        let dateString2 = bookingDate2 + " " + strValue2
        let inputDateFormatter2 = DateFormatter()
        inputDateFormatter2.dateFormat = "dd/MM/yyyy HH:mm a"
        let date2 = inputDateFormatter2.date(from: dateString2)

        let outputDateFormatter2 = DateFormatter()
        outputDateFormatter2.dateFormat = "yyyy-MM-dd HH:mm a"
        let datel =  outputDateFormatter2.string(from: date2!)

        var roomType = String()

        if appDelegate.selectedRoomType == "Classic" {
            if self.hotelDetailData?.data.rooms.count ?? 0 > 0 {
                roomType = self.hotelDetailData?.data.rooms[0].sid ?? ""
            }
        }else if appDelegate.selectedRoomType == "Delux"{
            if self.hotelDetailData?.data.rooms.count ?? 0 > 1{
            roomType = self.hotelDetailData?.data.rooms[1].sid ?? ""
            }
        }else {
            if self.hotelDetailData?.data.rooms.count ?? 0 > 2 {
            roomType = self.hotelDetailData?.data.rooms[2].sid ?? ""
            }
        }
        
        var bookingType = String()

        if (hotelBookingSelection[0]).isSelected {
            bookingType = "1"
        }else if (hotelBookingSelection[1]).isSelected {
            bookingType = "2"
        }else {
            bookingType = "3"
        }
        
        let para: Parameters = ["hotelId":selectedHotelID!,"name":txtName ?? "","phoneNumber":txtPhone ?? "","emailAddress":txtEmail ?? "","checkIn": date1 ,"checkOut":datel ,"adults":bookingGuest ?? "","child":bookingRoom ?? "","booking_type":bookingType,"payment":"\(isPayAtHotel)","room_type":roomType]
                
        
        
        WebServices.postRequest(urlApiString: "https://rooms24india.com/sh/api/v1/hotel_booking", paramters: para) { (json, message, status) in
            if status {
                KRProgressHUD.dismiss({
                    let str = "Your booking has been confirmed from \(self.bookingDate1), \(self.bookingTime1) to \(self.bookingDate2), \(self.bookingTime2) at \(self.titleHeading)."
            PopUpConfirmCommon2.showRequestPopup(strMgs: str, strTitle: "Congratulations!", strActionTitle: "Ok", isShowCloseButton: true, isRemoveAllSubview: false, acceptBlock: {

              let loginStoryBoard = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeInfoVC") as! HomeInfoVC
                self.navigationController?.pushViewController(loginStoryBoard, animated: true)

            })
                })
            } else{
                KRProgressHUD.dismiss({
                    PopupConfirmCommon.showRequestPopup(strMgs: message ?? "", strTitle: "ERROR")
                })
            }
        }
    }

    func validateFields() -> Bool {
        return validateAdultChild() && validateUsername() && validateEmail() && validatePhoneField()
    }

    func validateUsername() -> Bool {
        if txtName == "" {
            PopupConfirmCommon.showRequestPopup(strMgs: "Please enter user name!", strTitle: "Booking", acceptBlock: nil, rejectBlock: nil)
            return false
        }
        return true
    }
    func validatePhoneField() -> Bool {
        if txtPhone == "" {
            PopupConfirmCommon.showRequestPopup(strMgs: "Please enter phone number", strTitle: "Booking", acceptBlock: nil, rejectBlock: nil)
            return false
        } else {
            if txtPhone.count > 9 && txtPhone.count < 15 {
                return true
            } else {
                PopupConfirmCommon.showRequestPopup(strMgs: "Please enter correct phone number", strTitle: "Booking", acceptBlock: nil, rejectBlock: nil)
                return false
            }
        }
    }


    func validatePhoneNumber(value: String) -> Bool {
        let PHONE_REGEX = "^((\\+)|(00))[0-9]{6,14}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }


    func validateEmail() -> Bool {
        if txtEmail == "" {
            PopupConfirmCommon.showRequestPopup(strMgs: "Please enter email!", strTitle: "Booking", acceptBlock: nil, rejectBlock: nil)
            return false
        } else {
            if Utils.isValidEmail(Emailid: txtEmail) {
                return true
            } else {
                PopupConfirmCommon.showRequestPopup(strMgs: "Email is invalid!", strTitle: "Booking", acceptBlock: nil, rejectBlock: nil)
                return false
            }
        }
    }

    func validateAdultChild() -> Bool {
       if bookingGuest == "" {
            PopupConfirmCommon.showRequestPopup(strMgs: "Please select guest members", strTitle: "Booking", acceptBlock: nil, rejectBlock: nil)
            return false
        }
        else if bookingGuest == "Adults"{
            PopupConfirmCommon.showRequestPopup(strMgs: "Please select adult members", strTitle: "Booking")
            return false
        }
       if bookingRoom == "" {
           PopupConfirmCommon.showRequestPopup(strMgs: "Please select room count", strTitle: "Booking", acceptBlock: nil, rejectBlock: nil)
           return false
       }
       else if bookingRoom == "Childs"{
           PopupConfirmCommon.showRequestPopup(strMgs: "Please select child members", strTitle: "Booking")
           return false

       }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.accessibilityValue == "name" {
            txtName = textField.text!
        }else if textField.accessibilityValue == "email" {
          txtEmail = textField.text!
        }else {
          txtPhone = textField.text!
        }
    }
}

class PricingModel {
    var isCoupnSelect = false
}

class BtnStayHotelSelection {
    var isSelected = false
    
}

// RazorpayPaymentCompletionProtocol - This will execute two methods 1.Error and 2. Success case. On payment failure you will get a code and description. In payment success you will get the payment id.
extension HotalDetailVC : RazorpayPaymentCompletionProtocol {

    func onPaymentError(_ code: Int32, description str: String) {
        print("error: ", code, str)


        self.presentAlert(withTitle: "Alert", message: str)
    }

    func onPaymentSuccess(_ payment_id: String) {
        print("success: ", payment_id)
        self.presentAlert(withTitle: "Success", message: "Payment Succeeded")

    }

    func openRazorpayCheckout() {
        // 1. Initialize razorpay object with provided key. Also depending on your requirement you can assign delegate to self. It can be one of the protocol from RazorpayPaymentCompletionProtocolWithData, RazorpayPaymentCompletionProtocol.
        razorpayObj =  RazorpayCheckout.initWithKey(razorpayKey, andDelegate: self)
        let options: [AnyHashable:Any] = [
            "prefill": [
                "contact": "1234567890",
                "email": "a@a.com",
                "currency": "INR"
                //                "method":"wallet",
                //                "wallet":"amazonpay"
            ],
            "image": "http://www.freepngimg.com/download/light/2-2-light-free-download-png.png",
            "amount" : 499900,
            "timeout":90,
            "theme": [
                "color": "#F37254"
            ]
        ]
        if let rzp = self.razorpayObj {
            rzp.open(options)
        } else {
            print("Unable to initialize")
        }
    }
}

// RazorpayPaymentCompletionProtocolWithData - This will returns you the data in both error and success case. On payment failure you will get a code and description. In payment success you will get the payment id.
extension HotalDetailVC: RazorpayPaymentCompletionProtocolWithData {

    func onPaymentError(_ code: Int32, description str: String, andData response: [AnyHashable : Any]?) {
        print("error: ", code)
        self.presentAlert(withTitle: "Alert", message: str)
    }

    func onPaymentSuccess(_ payment_id: String, andData response: [AnyHashable : Any]?) {
        print("success: ", payment_id)
        self.presentAlert(withTitle: "Success", message: "Payment Succeeded")
        
       
        
    }
}

extension HotalDetailVC {
    func presentAlert(withTitle title: String?, message : String?) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "Ok", style: .cancel) { (alert) in
                if message == "Payment Succeeded" {
//                    let reportVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeInfoVC") as! HomeInfoVC
//                    self.navigationController?.pushViewController(reportVC, animated: true)
                    self.checkout()
                }
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true) {

            }
        }
    }
}

class RoomTypeSelection {
    
    var isSelected = false
}
