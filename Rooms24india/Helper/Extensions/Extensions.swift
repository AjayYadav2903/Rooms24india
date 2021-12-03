//
//  Extensions.swift
//  Rooms24india
//
//  Created by admin on 20/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

extension Error {
    var code: Int { return (self as NSError).code }
    var domain: String { return (self as NSError).domain }
}

var earlyDate = Calendar.current.date(
    byAdding: .minute,
  value: -1,
  to: Date())

extension UINavigationController {

    func setStatusBar(backgroundColor: UIColor) {
        let statusBarFrame: CGRect
        if #available(iOS 13.0, *) {
            statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        } else {
            statusBarFrame = UIApplication.shared.statusBarFrame
        }
        let statusBarView = UIView(frame: statusBarFrame)
        statusBarView.backgroundColor = backgroundColor
        view.addSubview(statusBarView)
    }

}

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

extension UILabel {

    func setDiffrentColor(string1: String,color1: Int = 0x000000,string2: String, color2: Int = 0x758692){
        var attrs1 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor : UIColor(netHex: color1)]
        
        var attrs2 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor : UIColor(netHex: color2)]
        if let fontBold = UIFont(name: "OpenSans-Semibold", size: 15), let fontNomal = UIFont(name: "OpenSans-Regular", size: 15) {
            attrs1 = [NSAttributedString.Key.font : fontBold, NSAttributedString.Key.foregroundColor : UIColor(netHex: color1)]
            attrs2 = [NSAttributedString.Key.font : fontNomal, NSAttributedString.Key.foregroundColor : UIColor(netHex: color2)]
        }

        
        let attributedString1 = NSMutableAttributedString(string: string1, attributes:attrs1)
        
        let attributedString2 = NSMutableAttributedString(string: string2, attributes:attrs2)
        
        let attributedStringBlank = NSMutableAttributedString(string: " ", attributes:attrs1)
        attributedString1.append(attributedStringBlank)
        attributedString1.append(attributedString2)
        self.attributedText = attributedString1
    }
    func setTextColorGradient(hexColorTop: String = "#9A21AD", hexColorBottom: String = "#218da2"){
        let image = getGradientImage(bounds: self.bounds, hexColorTop: hexColorTop, hexColorBottom: hexColorBottom)
        self.textColor = UIColor(patternImage: image)
    }
    func getGradientImage(bounds:CGRect, hexColorTop: String = "#8C2216", hexColorBottom: String = "#FFAA5E") -> UIImage
    {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(hexString: hexColorTop).cgColor, UIColor(hexString: hexColorBottom).cgColor]
        gradientLayer.bounds = bounds
        UIGraphicsBeginImageContextWithOptions(gradientLayer.bounds.size, true, 0.0)
        let context = UIGraphicsGetCurrentContext()
        gradientLayer.render(in: context!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    func setOnlyFirstText(text : String){
        if text.count > 0 {
            self.text = String(text.first!).uppercased()
        } else {
            self.text = ""
        }
        
    }
   
    
}

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
    func as1ptImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        let ctx = UIGraphicsGetCurrentContext()
        self.setFill()
        ctx!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

extension String {
    func toDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy  hh:mm"
        return formatter.date(from: self)
    }
}

extension String
{
    func isEmail() -> Bool
    {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
    
    var dateValue: Date?{
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
//            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            dateFormatter.timeZone = TimeZone.current
            let localDate = dateFormatter.date(from: self)
            return localDate
        }
        
    }
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributeString.length))
        return attributeString
    }
    func priceBeforeDiscount() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttributes([NSAttributedString.Key.font : UIFont(name: "Quicksand-Regular", size: 14), NSAttributedString.Key.foregroundColor : UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1)], range: NSMakeRange(0,attributeString.length))
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributeString.length))
        return attributeString
    }
    func priceAfterDiscount() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttributes([NSAttributedString.Key.font : UIFont(name: "Quicksand-Medium", size: 16), NSAttributedString.Key.foregroundColor : UIColor(red: 255/255, green: 100/255, blue: 80/255, alpha: 1)], range: NSMakeRange(0,attributeString.length))
            return attributeString
    }
    public func separate(withChar char : String) -> [String]{
        var word : String = ""
        var words : [String] = [String]()
        for chararacter in self {
            if String(chararacter) == char && word != "" {
                words.append(word)
                word = char
            }else {
                word += String(chararacter)
            }
        }
        words.append(word)
        return words
    }
    func resolveHashTagsExtension(nomalTextColor: UIColor = .black) -> NSAttributedString{
        var length : Int = 0
        let text:String = self
        let words:[String] = text.separate(withChar: " ")
        let hashtagWords = words.flatMap({$0.separate(withChar: "#")})
        var attrs = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor : nomalTextColor]
        if let fontNomal = UIFont(name: "OpenSans-Regular", size: 15) {
            attrs = [NSAttributedString.Key.font : fontNomal, NSAttributedString.Key.foregroundColor : nomalTextColor]
        }
        let attrString = NSMutableAttributedString(string: text, attributes:attrs)
        for word in hashtagWords {
            if word.hasPrefix("#") {
                let matchRange:NSRange = NSMakeRange(length, word.count)
                let stringifiedWord:String = word
                attrString.addAttribute(NSAttributedString.Key.link, value: "hash:\(stringifiedWord)", range: matchRange)
            }
            length += word.count
        }
        return attrString
    }
    var length: Int {
        return self.count
    }
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
    
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    func getFirstCharaterEachWord() -> String{
        var stringNeed = ""
        if self.count > 0 {
            let stringInputArr = self.separate(withChar: " ")
            for string in stringInputArr {
                stringNeed = stringNeed + String(string.first!)
            }
        }
        return stringNeed
        
    }
}

extension Date {
    
    func getElapsedInterval() -> String {
        
        let interval = Calendar.current.dateComponents([.year, .month,.weekOfMonth, .day, .hour, .minute, .second], from: self, to: Date())
        
        if let year = interval.year, year > 0 {
            return year == 1 ? "a" + " " + "year" :
                "\(year)" + " " + "years"
        } else if let month = interval.month, month > 0 {
            return month == 1 ? "a" + " " + "month" :
                "\(month)" + " " + "months"
        } else if let week = interval.weekOfMonth, week > 0 {
            return week == 1 ? "a" + " " + "week" :
                "\(week)" + " " + "weeks"
        }else if let day = interval.day, day > 0 {
            return day == 1 ? "a" + " " + "day" :
                "\(day)" + " " + "days"
        } else if let hour = interval.hour, hour > 0 {
            return hour == 1 ? "a" + " " + "hour" :
                "\(hour)" + " " + "hours"
        } else if let minute = interval.minute, minute > 0 {
            return minute == 1 ? "a" + " " + "minute" :
                "\(minute)" + " " + "minutes"
        }
//        else if let second = interval.second, second > 0 {
//            return second == 1 ? "\(second)" + " " + "second".localized :
//                "\(second)" + " " + "seconds".localized
//        }
        else {
            return "a moment ago"
        }
        
    }
    
    static func checkDateInInterval(startedTime: String, endTime: String) -> Bool {
        if startedTime == "" || endTime == "" { return false }
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = TimeZone.current
        let startedDate = dateFormatter.date(from: startedTime) ?? Date()
        let endDate = dateFormatter.date(from: endTime) ?? Date()
        if currentDate > startedDate && currentDate < endDate {
            return true
        }
        return false
    }
    
    static func componentsBetweenTwoDay(startedTime: String, endTime: String, component: Calendar.Component = .day) -> DateComponents {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = TimeZone.current
        let startedDate = dateFormatter.date(from: startedTime) ?? Date()
        let endDate = dateFormatter.date(from: endTime) ?? Date()
        dateFormatter.timeZone = TimeZone.current
        let calendar = Calendar.current
        let components = calendar.dateComponents([component], from: startedDate, to: endDate)
        return components
    }
    
    static func daysBetweenTwoDay(startedTime: String, endTime: String) -> Int {
        if startedTime == "" || endTime == "" { return 0 }
        let components = self.componentsBetweenTwoDay(startedTime: startedTime, endTime: endTime,component: .day)
        return components.day ?? 0
    }
    
    static func hoursBetweenTwoDay(startedTime: String, endTime: String) -> Int {
        if startedTime == "" || endTime == "" { return 0 }
        let components = self.componentsBetweenTwoDay(startedTime: startedTime, endTime: endTime,component: .hour)
        return components.hour ?? 0
    }
    
    static func minutesBetweenTwoDay(startedTime: String, endTime: String) -> Int {
        if startedTime == "" || endTime == "" { return 0 }
        let components = self.componentsBetweenTwoDay(startedTime: startedTime, endTime: endTime,component: .minute)
        return components.minute ?? 0
    }
}
extension Date {
    var isPast: Bool {
        return isPast(referenceDate: earlyDate ?? Date())
    }

    var isFuture: Bool {
        return !isPast
    }

    func isPast(referenceDate: Date) -> Bool {
        return timeIntervalSince(referenceDate) <= 0
    }

    func isFuture(referenceDate: Date) -> Bool {
        return !isPast(referenceDate: referenceDate)
    }

    // `Date` in memory is a wrap for `TimeInterval`. But in file attribute it can only accept `Int` number.
    // By default the system will `round` it. But it is not friendly for testing purpose.
    // So we always `ceil` the value when used for file attributes.
    var fileAttributeDate: Date {
        return Date(timeIntervalSince1970: ceil(timeIntervalSince1970))
    }
}

extension UIView {
   func createDottedLine(width: CGFloat, color: CGColor) {
      let caShapeLayer = CAShapeLayer()
      caShapeLayer.strokeColor = color
      caShapeLayer.lineWidth = width
      caShapeLayer.lineDashPattern = [2,3]
      let cgPath = CGMutablePath()
      let cgPoint = [CGPoint(x: 0, y: 0), CGPoint(x: self.frame.width, y: 0)]
      cgPath.addLines(between: cgPoint)
      caShapeLayer.path = cgPath
      layer.addSublayer(caShapeLayer)
   }
}

extension String {
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
}
