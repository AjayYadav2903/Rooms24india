//
//  HomeInfoVC.swift
//  Fingerprint
//
//  Created by admin on 03/06/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Alamofire
import KRProgressHUD
import SHSearchBar
import AddressBookUI
import Contacts

class HomeInfoVC: Rooms24BaseVC {
    
    
    @IBOutlet weak var tblHome : UITableView!
    @IBOutlet weak var searchBarHome : UISearchBar!
    @IBOutlet weak var vwBottomBar : View!
    @IBOutlet weak var topView : UIView!
    @IBOutlet weak var tabBar : UITabBar!
    @IBOutlet weak var lblNotification : UILabel!

    @IBOutlet weak var tabitem4 : UITabBarItem!

    
    var hotelData : DataClass?
    var addressSearchbarTop: SHSearchBar!
    var paginate = 1
    var perPage = 20
    var isLoading = false
    var arrNearyou = [Bestdeal]()

    
    var header = ["","","Recommended for you","Banquets,Conference and Corporate offices","New User offer","Trip & Travel","Destination",""]
    
    let imgSenitise = ["senitised1","senitised2","senitised3","senitised4"]
    
    let imgPlanTrip = ["solotrip","busticket","grouptrip","trainticket","faimlytrip","flightticket"]
    let namePlanTrip = ["Solo Trip","Bus Ticket","Group Trip","Railway Ticket","Faimly Trip","Flight Ticket"]
    
    let imgDestination = ["auli","Khajjiar","dehradun","haridwar","ladhak","manali","rishikesh","shimla","gulmarg"]
    let nameDestination = ["Auli","Khajjiar","Dehradun","Haridwar","Ladhak","Manali","Rishikesh","Shimla","Gulmarg"]
    
    let imgCities = ["","Arrah","Arwal","Begusarai","Bettiah","Bhagalpur","Bihar Sarif","Buxar","Chapra","Dharbhanga","Gaya","Gopalganj","Hajipur","Jahanabad","Jamuui","Kaimur","Katihar","kishanganj","koderama","Lakhisarie","Madhupura","Madhuwani","Motihari","Munger","Muzaffarpur","Nalanda","Nawada","Patna","Purenea","Rajgir","Raxaul","Rohtas","Saharsa","Samastipur","Sasaram","Sitamari","Siwan"]
    let nameCities = ["nearyou","Arrah","Arwal","Begusarai","Bettiah","Bhagalpur","Bihar Sarif","Buxar","Chapra","Dharbhanga","Gaya","Gopalganj","Hajipur","Jahanabad","Jamuui","Kaimur","Katihar","kishanganj","koderama","Lakhisarie","Madhupura","Madhuwani","Motihari","Munger","Muzaffarpur","Nalanda","Nawada","Patna","Purenea","Rajgir","Raxaul","Rohtas","Saharsa","Samastipur","Sasaram","Sitamari","Siwan"]
    
    var rasterSize: CGFloat = 11.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.selectedItem = tabBar.items?.first
        //self.startMonitoringInternet(backgroundColor:UIColor.gray, style: .cardView, textColor:UIColor.white, message:"please check your internet connection", remoteHostName: "")
        
        //        if let textfield = searchBarHome.value(forKey: "searchField") as? UITextField {
        //            textfield.backgroundColor = UIColor.white
        //        }
        self.navigationController?.isNavigationBarHidden = true
        serverRequest()
        searchBarUI()
        setProfileTabITem()
    }
    

    
    func setProfileTabITem()  {
        let imagePr = UIImageView()
        imagePr.kf.setImage(with: URL(string: AccountInfo.shared.loadUserModel().featuredImage), placeholder: Utils.genImgWithLetterFrom(displayName: AccountInfo.shared.loadUserModel().displayName == "" ? "G" : AccountInfo.shared.loadUserModel().displayName, dimension: 35))
        tabitem4.image = imagePr.image?.resizeWithWidth(width: 35)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        
        tabitem4.title = AccountInfo.shared.loadUserModel().displayName == "" ? "Guest" : AccountInfo.shared.loadUserModel().username
        if AccountInfo.shared.loadUserModel().displayName != "" {
            tabitem4.title = AccountInfo.shared.loadUserModel().displayName
        }
    }

    let addressFormatter: CNPostalAddressFormatter = {
        let formatter = CNPostalAddressFormatter()
        return formatter
    }()
    
    func searchBarUI()  {
        //        let addressTop = CNMutablePostalAddress()
        //        addressTop.city = "Frankfurt am Main"
        //        addressTop.street = "Mainzer Landstraße 123"
        let viewLeft = UIView()
        viewLeft.backgroundColor = UIColor.red
        let searchGlassIconTemplate = UIImage(named: "iconsearch")!
        let leftView1 = imageViewWithIcon(searchGlassIconTemplate, rasterSize: 3)
        viewLeft.addSubview(leftView1)
        
        addressSearchbarTop = defaultSearchBar(withRasterSize: rasterSize, leftView: leftView1, rightView: nil, delegate: self)
        
        //   addressSearchbarTop.text = addressFormatter.string(from: addressTop)
        addressSearchbarTop.updateBackgroundImage(withRadius: 10, corners: [.topLeft, .topRight,.bottomLeft,.bottomRight], color: UIColor.white)
        topView.addSubview(addressSearchbarTop)
        addressSearchbarTop.placeholder = "Search for Hotel,City or Location"
        addressSearchbarTop.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: addressSearchbarTop, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: topView, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: addressSearchbarTop, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: topView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: addressSearchbarTop, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: topView.frame.size.width).isActive = true
        NSLayoutConstraint(item: addressSearchbarTop, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: topView.frame.size.height).isActive = true
        
    }
    
    // MARK: - Helper Functions
    
    func defaultSearchBar(withRasterSize rasterSize: CGFloat,
                          leftView: UIView?,
                          rightView: UIView?,
                          delegate: SHSearchBarDelegate,
                          useCancelButton: Bool = true) -> SHSearchBar {
        
        var config = defaultSearchBarConfig(rasterSize)
        config.leftView = leftView
        config.rightView = rightView
        config.useCancelButton = useCancelButton
        
        if leftView != nil {
            config.leftViewMode = .always
        }
        
        if rightView != nil {
            config.rightViewMode = .unlessEditing
        }
        
        let bar = SHSearchBar(config: config)
        bar.delegate = delegate
        bar.placeholder = NSLocalizedString("sbe.textfieldPlaceholder.default", comment: "")
        bar.updateBackgroundImage(withRadius: 6, corners: [.allCorners], color: UIColor.white)
        bar.layer.shadowColor = UIColor.black.cgColor
        bar.layer.shadowOffset = CGSize(width: 0, height: 3)
        bar.layer.shadowRadius = 5
        bar.layer.shadowOpacity = 0.25
        return bar
    }
    
    func defaultSearchBarConfig(_ rasterSize: CGFloat) -> SHSearchBarConfig {
        var config: SHSearchBarConfig = SHSearchBarConfig()
        config.rasterSize = rasterSize
        //    config.cancelButtonTitle = NSLocalizedString("sbe.general.cancel", comment: "")
        config.cancelButtonTextAttributes = [.foregroundColor: UIColor.darkGray]
        config.textContentType = UITextContentType.fullStreetAddress.rawValue
        config.textAttributes = [.foregroundColor: UIColor.gray]
        return config
    }
    
    func imageViewWithIcon(_ icon: UIImage, rasterSize: CGFloat) -> UIImageView {
        let imgView = UIImageView(image: icon)
        imgView.frame = CGRect(x: 0, y: 0, width: 5, height: 5)
        imgView.contentMode = .center
        //imgView.tintColor = UIColor(red: 0.75, green: 0, blue: 0, alpha: 1)
        return imgView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //  setUpSearch()
        tabBar.selectedItem = tabBar.items?.first
        self.view.endEditing(true)
        addressSearchbarTop.resignFirstResponder()
        self.addressSearchbarTop.cancelSearch()
        setProfileTabITem()

    }
    
    ///Called when user touched shadowView
    func onClickShadowView(shadowView: UIView) {
        print("User touched shadowView")
    }
    
    func serverRequest()  {
        isLoading = true
        let para: Parameters = ["location":"delhi"]
        var apiHome = ""
        if (AccountInfo.shared.getToken()) == "" {
            apiHome = "home?paginate\(paginate)&perPage=\(perPage)"
        }else {
            apiHome = "userHome?paginate=\(paginate)&perPage=\(perPage)"
        }
        WebServices.postRequest(urlApiString: "https://rooms24india.com/sh/api/v1/\(apiHome)", paramters: para) { (json, message, status) in
            if status {
                
                let welcome = try? JSONDecoder().decode(Welcome.self, from: (json?.rawData())!)
                
                self.hotelData = welcome?.data
                if welcome != nil {
                    for arr in welcome!.data.nearyou {
                        self.arrNearyou.append(arr)
                    }
                }
                self.isLoading = false
                print(self.arrNearyou.count)
                self.tblHome.reloadData()
            } else{
                // KRProgressHUD.dismiss({
                //     PopupConfirmCommon.showRequestPopup(strMgs: message ?? "", strTitle: "ERROR")
                //  })
            }
        }    }
    
    
    
    @IBAction func btnActionDrawer(_ sender: UIButton) {
        toggleLeftSlide()
    }
    
    
    
    func toggleLeftSlide(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.drawerContainer?.toggle(MMDrawerSide.left, animated: true, completion: nil)
        
    }
    
    @IBAction func btnActionNotification(_ sender: UIButton) {
          let notificationVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
          self.navigationController?.pushViewController(notificationVC, animated: true)
       }
    
    @IBAction func btnActionHome(_ sender: UIButton) {
        
    }
    @IBAction func btnActionBooking(_ sender: UIButton) {
        let loginStoryBoard = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "BookingsList") as! BookingsList
        self.navigationController?.pushViewController(loginStoryBoard, animated: true)
        
    }
    @IBAction func btnActionWishList(_ sender: UIButton) {
        let loginStoryBoard = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "WishListVC") as! WishListVC
        self.navigationController?.pushViewController(loginStoryBoard, animated: true)
        
    }
    @IBAction func btnActionExplore(_ sender: UIButton) {
//        self.avatar.kf.setImage(with: URL(string: AccountInfo.shared.loadUserModel().featuredImage), placeholder: Utils.genImgWithLetterFrom(displayName: AccountInfo.shared.loadUserModel().displayName == "" ? "G" : AccountInfo.shared.loadUserModel().displayName, dimension: self.avatar.frame.width))

    }
}

extension HomeInfoVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return imgCities.count
        }
        if collectionView.tag == 1 {
            return imgSenitise.count
        }
        
        if collectionView.tag == 2 {
            return arrNearyou.count
        }
        if collectionView.tag == 3 {
            return 0//hotelData?.dormitories.count ?? 0
        }else if collectionView.tag == 4{
            return 1
        }else if collectionView.tag == 5 {
            return imgPlanTrip.count
        }else if collectionView.tag == 6 {
            return imgDestination.count
        }else if collectionView.tag == 7 {
            return 1
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CitiesCollCell", for: indexPath) as! CitiesCollCell
            if indexPath.row == 0 {
                let nearby = collectionView.dequeueReusableCell(withReuseIdentifier: "NearbyCollCell", for: indexPath) as! NearbyCollCell
                
                nearby.lblCityName.text = "Near by"
                nearby.imgCity.backgroundColor = UIColor.yellow
                do {
                    let gif = try UIImage(gifName: "location.gif", levelOfIntegrity:0.5)
                    nearby.imgCity.setGifImage(gif, loopCount: -1)
                } catch {
                    print(error)
                }
                return nearby
            }else {
                cell.lblCityName.text = nameCities[indexPath.row]
                cell.imgCity.image = UIImage(named: imgCities[indexPath.row])
                cell.imgCity.backgroundColor = UIColor.white
                
            }
            return cell
        }
        
        if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserInfoCollCell", for: indexPath) as! UserInfoCollCell
            cell.imgInfo.image = UIImage(named: imgSenitise[indexPath.row])
            // cell.lblAddress.text = nameDestination[indexPath.row]
            return cell
        }
        
        if collectionView.tag == 2 {
            if hotelData != nil {
                if indexPath.item == (arrNearyou.count - 1) && !isLoading   {
                    self.paginate += 1
                    serverRequest()
                }
            }

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NearYouCollCell", for: indexPath) as! NearYouCollCell
            let hotelDetail = arrNearyou[indexPath.row]
            if arrNearyou[indexPath.row].imgURL != "" {
                cell.imgHotel.kf.setImage(with: URL(string: arrNearyou[indexPath.row].imgURL )!)
            }
            cell.lblAddress.text = hotelDetail.hotelAddress
            cell.lblHotelName.text = hotelDetail.hotelName
            cell.lblPrice.text = "₹ \(hotelDetail.bookingPrice)"
            cell.lblDiscount.text = "₹ \(hotelDetail.discountPrice) OFF"
           
            cell.hotelRatings.text = "\(hotelDetail.hotelRatings ) ⭐"
            if hotelDetail.isOnWhishList {
                cell.isWishList.setImage(UIImage(named: "heartFillIcon"), for: .normal)
            }else {
                cell.isWishList.setImage(UIImage(named: "heartIcon"), for: .normal)
            }
            cell.isWishList.accessibilityHint = hotelDetail.hotelID
            cell.isWishList.tag = indexPath.row
            cell.isWishList.addTarget(self, action: #selector(serverRequestForWishList(sender:)), for: .touchUpInside)
            
            return cell
        }
        if collectionView.tag == 3 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DormitoryCollCell", for: indexPath) as! DormitoryCollCell
//            let hotelDetail = hotelData?.dormitories[indexPath.row]
//            if hotelData?.nearyou[indexPath.row].imgURL != "" {
//                cell.imgHotel.kf.setImage(with: URL(string: hotelData?.nearyou[indexPath.row].imgURL ?? "")!)
//            }
//            cell.lblHotelName.text = hotelDetail?.dormitoryName
//            cell.lblPrice.text = "₹ \(hotelDetail!.price)"
//            cell.lblDiscount.text = "₹ \(hotelDetail!.discount) OFF"
//
//            cell.isWishList.tag = indexPath.row
//            cell.isWishList.addTarget(self, action: #selector(serverRequestForWishList(sender:)), for: .touchUpInside)
            
            return cell
        }else if collectionView.tag == 4 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdvertisementCollCell1", for: indexPath) as! AdvertisementCollCell1
            return cell
        }else if collectionView.tag == 5 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BestDealsCollCell", for: indexPath) as! BestDealsCollCell
            cell.imgHotel.image = UIImage(named: imgPlanTrip[indexPath.row])
            cell.lblTripName.text = namePlanTrip[indexPath.row]
            //            cell.lblHotelName.text = hotelDetail?.hotelName
            //            cell.lblPrice.text = "₹ \(hotelDetail!.bookingPrice)"
            //            cell.lblKmAway.text = "0.5 km away"
            // cell.ratings.rating = hotelDetail?.hotelRatings ?? 0
            //          cell.isWishList.tag = indexPath.row
            //          cell.isWishList.addTarget(self, action: #selector(serverRequestForWishList(sender:)), for: .touchUpInside)
            
            return cell
        }else if collectionView.tag == 6 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularDestinationCollCell", for: indexPath) as! PopularDestinationCollCell
            //     if hotelData?.nearyou != nil {
            cell.imgHotel.image = UIImage(named: imgDestination[indexPath.row])
            cell.lblAddress.text = nameDestination[indexPath.row]
            
            //                let hotelDetail = hotelData?.nearyou[0]
            //                cell.imgHotel.kf.setImage(with: URL(string: hotelData?.populardestination[0].imgURL ?? "")!)
            
            //   }
            //            cell.lblAddress.text = hotelDetail?.hotelAddress
            //            cell.lblHotelName.text = hotelDetail?.hotelName
            //            cell.ratings.rating = hotelDetail?.hotelRatings ?? 0
            //            cell.isWishList.accessibilityHint = hotelDetail?.hotelID
            //            cell.isWishList.tag = indexPath.row
            //            if hotelDetail?.isOnWhishList ?? false {
            //                cell.isWishList.setImage(UIImage(named: "heartIcon"), for: .normal)
            //            }else {
            //                cell.isWishList.setImage(UIImage(named: "heartFillIcon"), for: .normal)
            //            }
            //            cell.isWishList.addTarget(self, action: #selector(serverRequestForWishList(sender:)), for: .touchUpInside)
            
            return cell
        }else if collectionView.tag == 7 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdvertisementCollCell2", for: indexPath) as! AdvertisementCollCell2
            do {
                let gif = try UIImage(gifName: "Cab.gif", levelOfIntegrity:0.5)
                cell.imgAdd2.setGifImage(gif, loopCount: -1)
            } catch {
                print(error)
            }
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = UIColor.red

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
        if collectionView.tag == 2 {
            let hotelDetailVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HotalDetailVC") as! HotalDetailVC
            let hotelDetail = arrNearyou[indexPath.row]
            hotelDetailVC.selectedHotelID = hotelDetail.hotelID
            hotelDetailVC.titleHeading = hotelDetail.hotelName
            
            self.navigationController?.pushViewController(hotelDetailVC, animated: true)
        }
        if collectionView.tag == 3 {
            let hotelDetailVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HotalDetailVC") as! HotalDetailVC
            let hotelDetail = hotelData?.nearyou[indexPath.row]
            hotelDetailVC.selectedHotelID = hotelDetail?.hotelID
            hotelDetailVC.titleHeading = hotelDetail?.hotelName ?? ""
            
            self.navigationController?.pushViewController(hotelDetailVC, animated: true)
        }
        if collectionView.tag == 0 {
            callSearchHotels(location : nameCities[indexPath.row])
        }
        
      
        
        
        if collectionView.tag == 6 {
            let hotelDetailVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "GroupTripForm") as! GroupTripForm
            self.navigationController?.pushViewController(hotelDetailVC, animated: true)
        }
        
        if collectionView.tag == 5 {
            var urlstr : String!
            switch indexPath.row {
            case 1:
                urlstr = "http://www.comfycons.com/travel/page-36433823"
                let openWeb = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "OpenWebView") as! OpenWebView
                openWeb.urlString = urlstr
                self.navigationController?.pushViewController(openWeb, animated: true)

            case 3:
                urlstr = "http://www.comfycons.com/flight-booking/page-2174525"
                let openWeb = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "OpenWebView") as! OpenWebView
                openWeb.urlString = urlstr
                self.navigationController?.pushViewController(openWeb, animated: true)

            case 5:
                urlstr = "http://www.comfycons.com/flight-booking/page-2174525"
                let openWeb = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "OpenWebView") as! OpenWebView
                openWeb.urlString = urlstr
                self.navigationController?.pushViewController(openWeb, animated: true)
                
            case 0:
                let hotelDetailVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "GroupTripForm") as! GroupTripForm
                self.navigationController?.pushViewController(hotelDetailVC, animated: true)
            case 2:
                let hotelDetailVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "GroupTripForm") as! GroupTripForm
                self.navigationController?.pushViewController(hotelDetailVC, animated: true)
            case 4:
                let hotelDetailVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "GroupTripForm") as! GroupTripForm
                self.navigationController?.pushViewController(hotelDetailVC, animated: true)
            default:
                urlstr = "http://www.comfycons.com/flight-booking/page-2174525"
            }
        }
        
        if collectionView.tag == 7 {
            let hotelDetailVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "BookTaxiVC") as! BookTaxiVC
            self.navigationController?.pushViewController(hotelDetailVC, animated: true)
        }
    }
    
    func callSearchHotels(location : String)  {
        self.addressSearchbarTop.cancelSearch()
        let searchHotel = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "SearchHotelVC") as! SearchHotelVC
        searchHotel.searchHotels = location
        self.navigationController?.pushViewController(searchHotel, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 0 {
            return CGSize(width: 65, height: 65)
        }
        if collectionView.tag == 1 {
            return CGSize(width: 190, height: 90)
        }
        if collectionView.tag == 2 {
            return CGSize(width: 180, height: 210)
        }else if collectionView.tag == 3 {
            return CGSize(width: 160, height: 170)
        }else if collectionView.tag == 4 {
            return CGSize(width: collectionView.frame.size.width - 15 , height: 130)
        }else if collectionView.tag == 5 {
            return CGSize(width: (collectionView.frame.size.width - 30)/3, height: (collectionView.frame.size.width - 30)/3)
        }else if collectionView.tag == 6 {
            return CGSize(width: (collectionView.frame.size.width - 30)/5, height: (collectionView.frame.size.width - 30)/5)
        }else if collectionView.tag == 7 {
            return CGSize(width: (collectionView.frame.size.width - 15), height: 130)
        }
        return CGSize(width: 300, height: 300)
    }
    
    @objc func serverRequestForWishList(sender:UIButton)  {
        if AccountInfo.shared.getToken() != "" {
            let para: Parameters = ["hotelId":sender.accessibilityHint ?? ""]
            sender.setImage(UIImage(named: "heartFillIcon"), for: .normal)
            WebServices.postRequest(urlApiString: "https://rooms24india.com/sh/api/v1/addtowhishlist", paramters: para) { (json, message, status) in
                if status {
                    //  PopupConfirmCommon.showRequestPopup(strMgs: message!, strTitle: "WishList", acceptBlock: nil, rejectBlock: nil)
                    if json?["data"]["is_in_whish_list"] == false {
                        KRProgressHUD.dismiss({
                            PopupConfirmCommon.showRequestPopup(strMgs: "Removed from wishlist.", strTitle: "WishList", strActionTitle: "OK", isShowCloseButton: false, isRemoveAllSubview: false, acceptBlock: {
                                self.serverRequest()
                            }) {
                                
                            }
                        })
                    }else {
                        KRProgressHUD.dismiss({
                            PopupConfirmCommon.showRequestPopup(strMgs: "Added to wishlist.", strTitle: "WishList", strActionTitle: "OK", isShowCloseButton: false, isRemoveAllSubview: false, acceptBlock: {
                                self.serverRequest()
                            }) {
                                
                            }
                        })
                    }
                } else{
                    KRProgressHUD.dismiss({
                        PopupConfirmCommon.showRequestPopup(strMgs: message ?? "", strTitle: "ERROR")
                    })
                }
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
}

extension HomeInfoVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTblCell", for: indexPath) as! HomeTblCell
        
        cell.btnHeader.setTitle(header[indexPath.row], for: .normal)
        if indexPath.row == 0 {
            cell.consBtnHeight.constant = 0
            cell.imgArrowRight.isHidden = true
        }else if indexPath.row == 1 {
            cell.consBtnHeight.constant = 0
            cell.imgArrowRight.isHidden = true
        }else if indexPath.row == 2 {
            cell.consBtnHeight.constant = 40
            cell.imgArrowRight.isHidden = true
        }else if indexPath.row == 3 {
            cell.consBtnHeight.constant = 40
            cell.imgArrowRight.isHidden = true
        }else if indexPath.row == 4 {
            cell.consBtnHeight.constant = 40
            cell.imgArrowRight.isHidden = true
        }else if indexPath.row == 5 {
            cell.consBtnHeight.constant = 40
            cell.imgArrowRight.isHidden = true
        }else if indexPath.row == 6 {
            cell.consBtnHeight.constant = 40
            cell.imgArrowRight.isHidden = true
        }else if indexPath.row == 7 {
            cell.consBtnHeight.constant = 0
            cell.imgArrowRight.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 90
        }else if indexPath.row == 1 {
            return 120
        }else if indexPath.row == 2 {
            return 275
        }else if indexPath.row == 3 {
            return 0
        }else if indexPath.row == 4 {
            return 200
        }else if indexPath.row == 5 {
            return 330
        }else if indexPath.row == 6 {
            return 150
        }else if indexPath.row == 7 {
            return 130
        }
        return 50
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? HomeTblCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
        //tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard cell is HomeTblCell else { return }
        
        // storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    }
}

extension HomeInfoVC : SHSearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: SHSearchBar) -> Bool {
        let loginStoryBoard = UIStoryboard(name: "Home", bundle:
            nil).instantiateViewController(withIdentifier: "SearchVC") as! SearchVC
     //   self.navigationController?.pushViewController(loginStoryBoard, animated: false)
                let keyWindow: UIWindow? = UIApplication.shared.keyWindow
                           let mainController: UIViewController? = keyWindow?.rootViewController
                           mainController?.present(loginStoryBoard, animated: true)
              //  self.present(mainController, animated: true) {
        loginStoryBoard.controllerMain = self
                    self.addressSearchbarTop.cancelSearch()
        
           // }
        return true
    }
    
    func searchBar(_ searchBar: SHSearchBar, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        addressSearchbarTop.resignFirstResponder()
    }
}

extension HomeInfoVC : UITabBarDelegate {
    
    func tabBar(_ tabBar: UITabBar, willBeginCustomizing items: [UITabBarItem]){
        
    }
    
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == 0 {
            
        }else if item.tag == 1 {
            let loginStoryBoard = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "BookingsList") as! BookingsList
            self.navigationController?.pushViewController(loginStoryBoard, animated: true)
            
        }else if item.tag == 2 {
            let loginStoryBoard = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "WishListVC") as! WishListVC
            self.navigationController?.pushViewController(loginStoryBoard, animated: true)
            
        }else if item.tag == 3 {
            let loginStoryBoard = UIStoryboard(name: "Leftmenu", bundle: nil).instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
            self.navigationController?.pushViewController(loginStoryBoard, animated: true)
            
        }else {
            let loginStoryBoard = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeInfoVC") as! HomeInfoVC
            self.navigationController?.pushViewController(loginStoryBoard, animated: true)
            
        }
    }
}

extension UIImage {
    func resizeWithPercent(percentage: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: size.width * percentage, height: size.height * percentage)))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
    func resizeWithWidth(width: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
}
