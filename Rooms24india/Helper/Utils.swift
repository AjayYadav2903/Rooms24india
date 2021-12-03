//
//  Utils.swift
//  Fingerprint
//
//  Created by admin on 03/06/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class Utils: NSObject {
    
    private static var vSpinner : UIView?

  static func isValidEmail(Emailid:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: Emailid)
   }
    
    static func isValidPassword(Password:String?) -> Bool {
        guard Password != nil else { return false }

        // at least one uppercase,
        // at least one digit
        // at least one lowercase
        // 8 characters total
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        return passwordTest.evaluate(with: Password)
    }
    
        static func convertDateToddMMyyyy(_ date: String) -> String
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            if let date = dateFormatter.date(from: date) {
    //            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                dateFormatter.timeZone = TimeZone.current
                dateFormatter.dateFormat = "dd-MM-yyyy"
                return  dateFormatter.string(from: date)
            }
            return ""
        }
    
    
    static func calculateContentHeight(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
 
    static func showAlert(title:String,msg:String,selfObj:UIViewController,completionBlock : @escaping()-> Void)  {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert) in
            completionBlock()
        }))

        // alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        selfObj.present(alert, animated: true)
    }
    
    static func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    static func randomNumbers(length: Int) -> String {
          let letters = "0123456789"
          return String((0..<length).map{ _ in letters.randomElement()! })
      }
    
    static func reportIDUDIDumbers() -> String {
            let uuid = UUID().uuidString
            return uuid
        }
    
    public static func showLoader(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = .clear
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        vSpinner = spinnerView
        vSpinner?.tag = 112233
    }

    public static func removeLoader() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
    
    public static func changePlaceholderColor(txtFld:UITextField,text:String) {
        txtFld.attributedPlaceholder = NSAttributedString(string: text,
       attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
        static func genImgWithLetterFrom(displayName: String, dimension: CGFloat, showBorder: Bool = true,isLiving : Bool = false, scaleLetter: CGFloat = 1, cornerRadius: CGFloat = 0) -> UIImage?{
            let dimInside = dimension - 2
            let label = UILabel(frame:CGRect(origin: CGPoint(x: 1,y :1), size: CGSize(width: dimInside, height: 2 * dimInside/5)))
            let firstLetter = String(displayName.first ?? " ")
            label.text = firstLetter.capitalized

            label.font = label.font.withSize(CGFloat(2 * scaleLetter * dimInside/5))
            label.textAlignment = NSTextAlignment.center
            label.setTextColorGradient()

            let view = UIView(frame:CGRect(origin: CGPoint(x: 1,y :1), size: CGSize(width: dimInside, height: dimInside)))
            view.cornerRadius = cornerRadius > 0 ? cornerRadius : CGFloat(dimInside/2)
            view.borderWidth = 1
            view.borderColor = showBorder || cornerRadius > 0 ? UIColor.gray : UIColor.clear
    //        view.borderColor = isLiving ? UIColor.init(red: 131/255, green: 51/255, blue: 169/255)  : UIColor.gray
            view.backgroundColor = UIColor.white
            label.center = view.center
            view.addSubview(label)
            let renderer = UIGraphicsImageRenderer(bounds: view.bounds)
            return renderer.image { rendererContext in
                view.layer.render(in: rendererContext.cgContext)
            }
    //        return UIImage(named: "defaultAvatar")
        }
    
    static func convertStringToJSONString(content:String, imageURL:String?, width:Int, height:Int) -> String{
        var jsonStr = ""
        var json = [String:Any]()
        
        if imageURL != nil {
            json["type"] = "image"
            json["message"] = imageURL
            json["width"] = width
            json["height"] = height
        }
        else {
            json["message"] = content
            json["type"] = "text"
            json["width"] = width
            json["height"] = height
        }
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
        jsonStr = String(data: jsonData, encoding: String.Encoding.utf8)!
        return jsonStr
    }
    
    static func convertJSONStrToModel(jsonStr :String) -> Message? {
        var msgModel = Message()
        let data = jsonStr.data(using: .utf8)!
        do {
             msgModel = try JSONDecoder().decode(Message.self, from: data)
        } catch let error as NSError {
            print(error)
        }
        return msgModel
    }
}

class TextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
