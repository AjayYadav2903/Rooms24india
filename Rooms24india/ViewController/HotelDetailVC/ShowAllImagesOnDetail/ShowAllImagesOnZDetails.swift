//
//  ShowAllImagesOnZDetails.swift
//  Rooms24india
//
//  Created by admin on 05/09/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Alamofire
import ImageSlideshow
import KRProgressHUD

class ShowAllImagesOnZDetails: UIViewController {

    @IBOutlet weak var imgeSlide: ImageFullScreen!

    var arrFeatureImage:[String] = []
    var selectedIndex:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSlideShowImg()
        self.imgeSlide.setCurrentPage(selectedIndex ?? 0, animated: true)
    }
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
            
    func setSlideShowImg() {
        //setup slide
        if self.arrFeatureImage.count > 0{
            var datasource:[KingfisherSource] = [KingfisherSource]()
            for img in self.arrFeatureImage {
                datasource.append(KingfisherSource(urlString: img)!)
            }
            
            self.imgeSlide.slideshowInterval = 2.0
            self.imgeSlide.contentMode = .scaleAspectFit
            self.imgeSlide.pageIndicatorPosition = .init(horizontal: .center, vertical: .bottom)
            self.imgeSlide.contentScaleMode = UIView.ContentMode.scaleAspectFit
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
}
