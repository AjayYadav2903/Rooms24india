//
//  TermsConditionsVC.swift
//  Rooms24india
//
//  Created by admin on 23/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import PDFKit

class TermsConditionsVC: Rooms24BaseVC {

    var descritionTitle = String()
    var descritionValue = String()
    @IBOutlet weak var pdfView: PDFView!
    @IBOutlet weak var lblTitleOfPage : UILabel!
    @IBOutlet weak var lblDescription : UITextView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        //self.startMonitoringInternet(backgroundColor:UIColor.gray, style: .cardView, textColor:UIColor.white, message:"please check your internet connection", remoteHostName: "")
      //  lblDescription.text = descritionValue
        if let path = Bundle.main.path(forResource: "termspolicy", ofType: "pdf") {
            if let pdfDocument = PDFDocument(url: URL(fileURLWithPath: path)) {
                pdfView.displayMode = .singlePageContinuous
                pdfView.autoScales = true
                pdfView.displayDirection = .vertical
                pdfView.document = pdfDocument
            }
        }
    }
    
    @IBAction func btnBackction(_ sender: UIButton) {
            toggleLeftSlide()
        }
    
    func toggleLeftSlide(){
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.drawerContainer?.toggle(MMDrawerSide.left, animated: true, completion: nil)
            }
}
