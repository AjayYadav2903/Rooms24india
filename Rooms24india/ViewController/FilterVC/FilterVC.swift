//
//  FilterVC.swift
//  VSSHR
//
//  Created by admin on 28/09/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Alamofire


protocol FilterData {
    func filteredData(data : DataClass)
}
class FilterVC: UIViewController {
    @IBOutlet weak var tblItemFilter : UITableView!
    @IBOutlet weak var tblSelectItemFilter : UITableView!
    
    let tblLeftItems = ["Price","Amenities & Facilities","Pay at Hotel","Sanitised Stays","Cities"]
    let tblRightItems = ["Price","Price","Price","Price","Price","Price"]
    
    
    var filterItemMain : [FilterItemModel]!
    var selectedRowItem = 0
    
    let price = ["500-800","800-1000","1000-1200","1200-2500"]
    let amenities = ["Hair Dryer","TV","Free wifi","Power Backup","Parking Facility","Card Payment","CCTV Cameras","Private Entrance","Reception","24/7 checkin","Onsen/Hot Spring","Public Bath - Male","Daily Hosuekeeping","Fire-Extinguisher","First Aid","Toiletries","Buzzer/Door Bell","Attached Bathroom","Public Bath - Female","Private Onsen/Bath"]
    let payathotel = ["Pay at Hotel"]
    let sanitisedstay = ["Sanitised Stays"]
    let cities = ["Arrah","Arwal","Begusarai","Bettiah","Bhagalpur","Bihar Sarif","Buxar","Chapra","Dharbhanga","Gaya","Gopalganj","Hajipur","Jahanabad","Jamuui","Kaimur","Katihar","kishanganj","koderama","Lakhisarie","Madhupura","Madhuwani","Motihari","Munger","Muzaffarpur","Nalanda","Nawada","Patna","Purenea","Rajgir","Raxaul","Rohtas","Saharsa","Samastipur","Sasaram","Sitamari","Siwan"]
    var hotelData : DataClass?
    var delegate : FilterData?
    var selectedItemArr : [String]?
    var selectedItemDict : Parameters?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterItemMain = [FilterItemModel]()
        var filterItems1 = [FilterSelectItemModel]()
        var filterItems2 = [FilterSelectItemModel]()
        var filterItems3 = [FilterSelectItemModel]()
        var filterItems4 = [FilterSelectItemModel]()
        var filterItems5 = [FilterSelectItemModel]()

        var item1 : FilterSelectItemModel!
        var item2 : FilterSelectItemModel!
        var item3 : FilterSelectItemModel!
        var item4 : FilterSelectItemModel!
        var item5 : FilterSelectItemModel!

        for pr in price {
            item1 = FilterSelectItemModel()
            item1.isSelectedItem = false
            item1.value = pr
            filterItems1.append(item1)
        }
        
        for ame in amenities {
            item2 = FilterSelectItemModel()
            item2.isSelectedItem = false
            item2.value = ame
            filterItems2.append(item2)
        }
        
        for ame in payathotel {
            item3 = FilterSelectItemModel()
            item3.isSelectedItem = false
            item3.value = ame
            filterItems3.append(item3)
        }
        for ame in sanitisedstay {
            item4 = FilterSelectItemModel()
            item4.isSelectedItem = false
            item4.value = ame
            filterItems4.append(item4)
        }
        for ame in cities {
            item5 = FilterSelectItemModel()
            item5.isSelectedItem = false
            item5.value = ame
            filterItems5.append(item5)
        }
        
        for i in 0..<tblLeftItems.count {
            if i == 0 {
                let filterItemM = FilterItemModel()
                filterItemM.isSelected = false
                filterItemM.selectedKey = tblLeftItems[i]
                filterItemM.backgroudColor = UIColor.black
                filterItemM.items = filterItems1
                filterItemMain.append(filterItemM)
            }else if i == 1 {
                let filterItemM = FilterItemModel()
                filterItemM.isSelected = false
                filterItemM.selectedKey = tblLeftItems[i]
                filterItemM.backgroudColor = UIColor.black
                filterItemM.items = filterItems2
                filterItemMain.append(filterItemM)
            }else if i == 2 {
                let filterItemM = FilterItemModel()
                filterItemM.isSelected = false
                filterItemM.selectedKey = tblLeftItems[i]
                filterItemM.backgroudColor = UIColor.black
                filterItemM.items = filterItems3
                filterItemMain.append(filterItemM)
            }else if i == 3 {
                let filterItemM = FilterItemModel()
                filterItemM.isSelected = false
                filterItemM.selectedKey = tblLeftItems[i]
                filterItemM.backgroudColor = UIColor.black
                filterItemM.items = filterItems4
                filterItemMain.append(filterItemM)
            }else if i == 4 {
                let filterItemM = FilterItemModel()
                filterItemM.isSelected = false
                filterItemM.selectedKey = tblLeftItems[i]
                filterItemM.backgroudColor = UIColor.black
                filterItemM.items = filterItems5
                filterItemMain.append(filterItemM)
            }else {
                let filterItemM = FilterItemModel()
                filterItemM.isSelected = false
                filterItemM.selectedKey = tblLeftItems[i]
                filterItemM.backgroudColor = UIColor.black
                filterItemMain.append(filterItemM)
            }
        }
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func serverRequest()  {

      //  let para: Parameters = ["price" : ["2000-3000"],"amenities" : ["parking", "kitchen"],"cities":["delhi"]]
        let para: Parameters = ["price" : ["2000-3000"]]

         let apiFilter = "https://rooms24india.com/sh/api/v1/filter"
        
        WebServices.postRequest(urlApiString: apiFilter, paramters: selectedItemDict!) { (json, message, status) in
            if status {

                let welcome = try? JSONDecoder().decode(Welcome.self, from: (json?.rawData())!)
                self.hotelData = welcome?.data
                if self.hotelData != nil {
                    self.delegate?.filteredData(data: self.hotelData!)
                }
            self.navigationController?.popViewController(animated: true)

            } else{
               // KRProgressHUD.dismiss({
               //     PopupConfirmCommon.showRequestPopup(strMgs: message ?? "", strTitle: "ERROR")
              //  })
            }
        }
    }
    
    @IBAction func btnActionDrawer(_ sender: UIButton) {
        toggleLeftSlide()
    }
    
    @IBAction func btnActionClearAll(_ sender: UIButton) {
        for i in 0..<filterItemMain.count {
            if filterItemMain[i].items != nil {
                for j in filterItemMain[i].items {
                    j.isSelectedItem = false
                }
            }
        }
        tblSelectItemFilter.reloadData()
    }
    
    @IBAction func btnActionClose(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)

    }
 
    @IBAction func btnActionApply(_ sender: UIButton) {
      getAllFilteredItems()
      serverRequest()
     //
    }
    
    func getAllFilteredItems()  {
        selectedItemDict = Parameters()
        for i in 0..<filterItemMain.count {
            for j in 0..<filterItemMain[i].items.count {
                if (filterItemMain[i]).items[j].isSelectedItem {
                    selectedItemArr = [String]()
                    selectedItemArr?.append((filterItemMain[i]).items[j].value)
                    if filterItemMain[i].selectedKey == "Pay at Hotel" || filterItemMain[i].selectedKey == "Sanitised Stays" {
                        selectedItemDict?["facilities"] = selectedItemArr
                    }else {
                        selectedItemDict?[filterItemMain[i].selectedKey.lowercased()] = selectedItemArr

                    }
                    print(selectedItemArr)
                    print(selectedItemDict)
                }
            }
        }
    }
    
    @IBAction func btnActionBack(_ sender: UIButton) {
     self.navigationController?.popViewController(animated: true)
       }
    
    func toggleLeftSlide(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.drawerContainer?.toggle(MMDrawerSide.left, animated: true, completion: nil)
    }
}

extension FilterVC : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblItemFilter {
            return filterItemMain.count
        }
        if (filterItemMain[selectedRowItem]).items != nil {
            return (filterItemMain[selectedRowItem]).items.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tblItemFilter {
            let  cell = tableView.dequeueReusableCell(withIdentifier: "FilterItemCell", for: indexPath) as! FilterItemCell
            if (filterItemMain[indexPath.row]).isSelected {
                cell.lblItem.textColor = UIColor(hexString: "#047BD5")
            }else {
                cell.lblItem.textColor = (filterItemMain[indexPath.row]).backgroudColor
            }
            cell.lblItem.text = tblLeftItems[indexPath.row]
            if indexPath.row == filterItemMain.count - 1 {
              cell.vwBoderLine.isHidden = true
            }else {
              cell.vwBoderLine.isHidden = false
            }
            
            return cell
        }else {
            let  cell = tableView.dequeueReusableCell(withIdentifier: "FilterItemSelectonCell", for: indexPath) as! FilterItemSelectonCell
            cell.lblSelectedItem.text = (filterItemMain[selectedRowItem]).items[indexPath.row].value
            if (filterItemMain[selectedRowItem]).items[indexPath.row].isSelectedItem {
                cell.imgSelection.image = UIImage(named: "tickgreenfill")
                
            }else {
                cell.imgSelection.image = UIImage(named: "untickcoupon")
                
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tblItemFilter {
            selectedRowItem = indexPath.row
            filterItemMain[indexPath.row].isSelected = true
            filterItemMain[indexPath.row].selectedKey = tblLeftItems[indexPath.row]
            filterItemMain[indexPath.row].backgroudColor = UIColor.black
            selectUnselectItems(indexpath: indexPath.row)
        }else {
            if (filterItemMain[selectedRowItem]).items[indexPath.row].isSelectedItem {
                (filterItemMain[selectedRowItem]).items[indexPath.row].isSelectedItem = false
            }else {
                (filterItemMain[selectedRowItem]).items[indexPath.row].isSelectedItem = true
            }
            tblSelectItemFilter.reloadData()
        }
    }
    
    func selectUnselectItems(indexpath : Int)  {
        for i in 0..<filterItemMain.count {
            if i == indexpath {
                filterItemMain[i].isSelected = true
            }else {
                filterItemMain[i].isSelected = false
            }
        }
        tblItemFilter.reloadData()
        tblSelectItemFilter.reloadData()
    }
    
    func selectUnselectItemsInRigntTbl(indexpath : Int)  {
        for i in 0..<(filterItemMain[selectedRowItem]).items.count {
            (filterItemMain[selectedRowItem]).items[i].isSelectedItem = !(filterItemMain[selectedRowItem]).items[i].isSelectedItem
        }
        tblSelectItemFilter.reloadData()
    }
}
