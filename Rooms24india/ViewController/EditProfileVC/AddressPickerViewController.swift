//
//  AddressPickerViewController.swift
//  AirVting
//
//  Created by SeiLK on 8/2/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

public enum PlaceType: CustomStringConvertible {
    case All
    case Geocode
    case Address
    case Establishment
    case Regions
    case Cities
    case None
    
    public var description : String {
        switch self {
        case .All: return ""
        case .Geocode: return "geocode"
        case .Address: return "address"
        case .Establishment: return "establishment"
        case .Regions: return "(regions)"
        case .Cities: return "(cities)"
        case .None: return "None"
        }
    }
}

protocol AddressPickerDelegate: class {
    func didPickAdress(at address: String, latitude: Double, longtitude: Double)
}

class AddressPickerViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var suggestedPlacesList = [Place]()
    weak var delegate: AddressPickerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.becomeFirstResponder()
    }

    @IBAction func dismissView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchBar.text?.count)! > 0 {
            // Start to Send text to google place api
            getPlaces(searchString: searchBar.text!, placeType: .Cities) { (places) in
                
            }
        } else {
            suggestedPlacesList = []
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suggestedPlacesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row >= suggestedPlacesList.count {
            return UITableViewCell()
        }
        var cell: UITableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        }
        cell.textLabel?.text = suggestedPlacesList[indexPath.row].description
        return cell
    }
    
    func getPlaces(searchString: String , placeType:PlaceType  , succeed: (_ places : [Place]) -> Void) {
        let refinedSearchString = searchString.replacingOccurrences(of: " ", with: "+")
        let urlString = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=\(refinedSearchString)&types=\(placeType.description)&key=\(Constants.APIKey.googleApiKey)"
        Alamofire.request(urlString, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            print("____api response:: [\(urlString)] \(response)")
            switch response.result {
            case .success:
                if let actualData = response.data {
                    do {
                        let json = try JSON(data: actualData)
                        if let predictions = json["predictions"].array {
                            self.suggestedPlacesList = []
                            for prediction in predictions {
                                let place = Place(json: prediction)
                                self.suggestedPlacesList.append(place)
                            }
                            self.tableView.reloadData()
                        }
                    } catch {
//                        print("____api error", error)
                    }
                }
            case .failure(let error):
                print("____api error", error)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let placeId = suggestedPlacesList[indexPath.row].place_id
        let urlString = "https://maps.googleapis.com/maps/api/place/details/json?placeid=\(placeId)&key=\(Constants.APIKey.googleApiKey)"
        Alamofire.request(urlString, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            print("____api response: [\(urlString)] \(response)")
            switch response.result {
            case .success:
                if let actualData = response.data {
                    do {
                        let json = try JSON(data: actualData)
                        let location = json["result"]["geometry"]["location"]
                        var latitude = location["lat"].double
                        var longtitude = location["lng"].double
                        let description = self.suggestedPlacesList[indexPath.row].description
                        // bypass this until user can add billing account to google place api
                        if latitude == nil || longtitude == nil {
                            latitude = 0
                            longtitude = 0
                        }
                        self.delegate?.didPickAdress(at: description, latitude: latitude!, longtitude: longtitude!)
                        self.dismiss(animated: true, completion: nil)
                    } catch {
                        print("____api error", error)
                    }
                }
            case .failure(let error):
                print("____api error", error)
            }
        }
    }
}
