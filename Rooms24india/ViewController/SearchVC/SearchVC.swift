//
//  ViewController.swift
//  YNSearch
//
//  Created by YiSeungyoun on 2017. 4. 16..
//  Copyright © 2017년 SeungyounYi. All rights reserved.
//

import UIKit
import YNSearch

class YNDropDownMenu: YNSearchModel {
    var starCount = 512
    var description = "Awesome Dropdown menu for iOS with Swift 3"
    var version = "2.3.0"
    var url = "https://github.com/younatics/YNDropDownMenu"
}

class YNSearchData: YNSearchModel {
    var title = "YNSearch"
    var starCount = 271
    var description = "Awesome fully customize search view like Pinterest written in Swift 3"
    var version = "0.3.1"
    var url = "https://github.com/younatics/YNSearch"
}

class YNExpandableCell: YNSearchModel {
    var title = "YNExpandableCell"
    var starCount = 191
    var description = "Awesome expandable, collapsible tableview cell for iOS written in Swift 3"
    var version = "1.1.0"
    var url = "https://github.com/younatics/YNExpandableCell"
}

class SearchVC: YNSearchViewController, YNSearchDelegate {
    var controllerMain = HomeInfoVC()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let demoCategories = ["Arrah","Arwal","Begusarai","Bettiah","Bhagalpur","Bihar Sarif","Buxar","Chapra","Dharbhanga","Gaya","Gopalganj","Hajipur","Jahanabad","Jamuui","Kaimur","Katihar","kishanganj","koderama","Lakhisarie","Madhupura","Madhuwani","Motihari","Munger","Muzaffarpur","Nalanda","Nawada","Patna","Purenea","Rajgir","Raxaul","Rohtas","Saharsa","Samastipur","Sasaram","Sitamari","Siwan"]
        let demoSearchHistories = ["Menu", "Animation", "Transition", "TableView"]
        
        let ynSearch = YNSearch()
        ynSearch.setCategories(value: demoCategories)
       // ynSearch.setSearchHistories(value: demoSearchHistories)
    
        self.ynSearchinit()
        
        self.delegate = self
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        let database1 = YNDropDownMenu(key: "YNDropDownMenu")
        let database2 = YNSearchData(key: "Amritsar")
        let database3 = YNExpandableCell(key: "YNExpandableCell")
        var demoDatabase = [database2]

        
        for i in 0..<demoCategories.count {
          let database2 = YNSearchData(key: demoCategories[i])
            demoDatabase.append(database2)
            
        }
        
        
        self.initData(database: demoDatabase)
        self.setYNCategoryButtonType(type: .colorful)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func ynSearchListViewDidScroll() {
        self.ynSearchTextfieldView.ynSearchTextField.endEditing(true)
    }
    

    func ynSearchHistoryButtonClicked(text: String) {
        self.pushViewController(text: text)
        callSearchHotels(searchKey: text)
        dismiss(animated: false, completion: nil)
        print(text)
    }
    
    func ynCategoryButtonClicked(text: String) {
        self.callSearchHotels(searchKey: text)
        self.pushViewController(text: text)
        dismiss(animated: false, completion: nil)
        print(text)
    }
    
    func ynSearchListViewClicked(key: String) {
        
        self.pushViewController(text: key)
        callSearchHotels(searchKey: key)
        dismiss(animated: false, completion: nil)

        print(key)
    }
    
//    func ynSearchListViewClicked(object: Any) {
//        print(object)
//        callSearchHotels()
//    }
    
    func callSearchHotels(searchKey : String )  {
        let searchHotel = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "SearchHotelVC") as! SearchHotelVC
        searchHotel.searchHotels = searchKey
        controllerMain.navigationController?.pushViewController(searchHotel, animated: true)
    }
    
    func ynSearchListView(_ ynSearchListView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.ynSearchView.ynSearchListView.dequeueReusableCell(withIdentifier: YNSearchListViewCell.ID) as! YNSearchListViewCell
        if let ynmodel = self.ynSearchView.ynSearchListView.searchResultDatabase[indexPath.row] as? YNSearchModel {
            cell.searchLabel.text = ynmodel.key
        }
        
        return cell
    }
    
    func ynSearchListView(_ ynSearchListView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let ynmodel = self.ynSearchView.ynSearchListView.searchResultDatabase[indexPath.row] as? YNSearchModel, let key = ynmodel.key {
            self.ynSearchView.ynSearchListView.ynSearchListViewDelegate?.ynSearchListViewClicked(key: key)
            self.ynSearchView.ynSearchListView.ynSearchListViewDelegate?.ynSearchListViewClicked(object: self.ynSearchView.ynSearchListView.database[indexPath.row])
            self.ynSearchView.ynSearchListView.ynSearch.appendSearchHistories(value: key)
        }
    }
    
    func pushViewController(text:String) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "detail") as! DetailViewController
//        vc.clickedText = text
//        
//        self.present(vc, animated: true, completion: nil)
    }

    func ynSearchMainViewSearchHistoryChanged() {
        
    }
    
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.callSearchHotels(searchKey: textField.text!)
        self.pushViewController(text: textField.text!)
        dismiss(animated: false, completion: nil)
        return true
    }
}

