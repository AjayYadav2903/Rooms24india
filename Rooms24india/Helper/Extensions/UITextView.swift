//
//  UITextView.swift
//  AirVting
//
//  Created by Apple on 8/8/18.
//  Copyright © 2018 Admin. All rights reserved.
// reference https://stackoverflow.com/questions/48154641/hashtags-in-arabic-language-crashes-the-app

import Foundation
import UIKit

let hashtagHighlightFont = UIFont(name: "OpenSans-Semibold", size: 16) ?? UIFont.boldSystemFont(ofSize: 16)
let hashtagNormalFont = UIFont(name: "OpenSans-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16)
var hashtagNormalTextColor = UIColor(hexString: "#000000")
var hashtagHighlightTextColor = UIColor(hexString: "#2196F3")
extension UITextView {
    
    func resolveHashtag(normalFont: UIFont = hashtagNormalFont, normalTextColor: UIColor = hashtagNormalTextColor, highlightFont: UIFont = hashtagHighlightFont, highlightTextColor: UIColor = hashtagHighlightTextColor) {
        let text = self.text ?? ""
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: normalTextColor,
            .font: normalFont
        ]
        
        let highLightAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: highlightTextColor,
            .font: highlightFont
        ]
        
        let newStr = NSMutableAttributedString(string: text)
        newStr.addAttributes(normalAttributes, range: NSMakeRange(0, text.count))
        do {
            let regex = try NSRegularExpression(pattern: "(?:\\B|^)(#(?:[a-zA-Z].*?|\\d+[a-zA-Z]+.*?))\\b")
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            let ranges = results.map( {
                $0.range
            })
            
            if ranges.count > 0 {
                for range in ranges {
                    newStr.addAttributes(highLightAttributes, range: range)
                }
            }
            self.attributedText = newStr
        }
        catch {
            
        }
    }
    /*
    func setHashTag(username: String, contentWithHashTag: String){
        var attrs1 = [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 15), NSAttributedStringKey.foregroundColor : UIColor.black]
        if let fontBold = UIFont(name: "OpenSans-Semibold", size: 15) {
            attrs1 = [NSAttributedStringKey.font : fontBold]
        }
        let attributedString1 = NSMutableAttributedString(string: username, attributes:attrs1)
        
        attributedString1.append(NSAttributedString(string: username, attributes: [
            NSAttributedStringKey.link : "hash://\(username.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "default")",
            NSAttributedStringKey.foregroundColor : UIColor.green
            ]))
        
        attributedString1.append(NSAttributedString(string: username, attributes: [
            NSAttributedStringKey.link : URL(string: "https://www.apple.com")!,
            NSAttributedStringKey.foregroundColor : UIColor.blue,
            NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue
            ]))
        
        attributedString1.append(contentWithHashTag.resolveHashTagsExtension(nomalTextColor: UIColor(netHex: 0x758692)))
        self.attributedText = attributedString1
    }
 */
    func setTextWithUsernameAndHashtag(isOnline: Bool = false,username: String,colorUsername: UIColor = UIColor.black, contentWithHashTag: String, colorContent: UIColor = UIColor(netHex: 0x758692) ){
        var salerName = username
        if salerName.count > 15 {
            salerName = salerName.substring(toIndex: 12)
            salerName = salerName + "..."
        }
        let fontUserNameFamily = UIFont(name: "OpenSans-Semibold", size: 15) ?? UIFont.systemFont(ofSize: 15)
        let fontContentFamily = UIFont(name: "OpenSans-Regular", size: 15) ?? UIFont.systemFont(ofSize: 15)
        let attributedString = NSMutableAttributedString()
        attributedString.append(NSAttributedString(string: "\(salerName) ", attributes: [
            NSAttributedString.Key.link : "hash://\(salerName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")",
            NSAttributedString.Key.foregroundColor : colorUsername, NSAttributedString.Key.font : fontUserNameFamily
            ]))
        if isOnline {
            // create our NSTextAttachment
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = UIImage(named: "ic_online_m")
            
            // wrap the attachment in its own attributed string so we can append it
            let imageString = NSAttributedString(attachment: imageAttachment)
            attributedString.append(imageString)
            attributedString.append(NSAttributedString(string: " "))
        }
        
        
        let words:[String] = contentWithHashTag.separate(withChar: " ")
        for i in 0 ..< words.count {
            if words[i].trimmingCharacters(in: .whitespaces).prefix(1) == "#" && words[i].count > 1{
                attributedString.append(NSAttributedString(string: words[i], attributes: [
                    NSAttributedString.Key.link : "mention://\(words[i].trimmingCharacters(in: .whitespaces).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")",
                    NSAttributedString.Key.foregroundColor : UIColor(netHex: 0x157EFB), NSAttributedString.Key.font : fontUserNameFamily
                    ]))
            } else {
                attributedString.append(NSAttributedString(string: words[i], attributes: [
                    NSAttributedString.Key.foregroundColor : colorContent, NSAttributedString.Key.font : fontContentFamily
                    ]))
            }
        }
        self.attributedText = attributedString
        
    }
    
    func setTextWithUsername(isOnline: Bool = false,username: String,colorUsername: UIColor = UIColor.black){
        var salerName = username
        if salerName.count > 15 {
            salerName = salerName.substring(toIndex: 12)
            salerName = salerName + "..."
        }
        let fontUserNameFamily = UIFont(name: "OpenSans-Semibold", size: 15) ?? UIFont.systemFont(ofSize: 15)
        let fontContentFamily = UIFont(name: "OpenSans-Regular", size: 15) ?? UIFont.systemFont(ofSize: 15)
        let attributedString = NSMutableAttributedString()
        attributedString.append(NSAttributedString(string: "\(salerName) ", attributes: [
            NSAttributedString.Key.link : "hash://\(salerName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")",
            NSAttributedString.Key.foregroundColor : colorUsername, NSAttributedString.Key.font : fontUserNameFamily
            ]))
        if isOnline {
            // create our NSTextAttachment
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = UIImage(named: "ic_online_m")
            
            // wrap the attachment in its own attributed string so we can append it
            let imageString = NSAttributedString(attachment: imageAttachment)
            attributedString.append(imageString)
            attributedString.append(NSAttributedString(string: " "))
        }
        
        self.attributedText = attributedString
        
    }
    
    func setTextWithContentHashtag(contentWithHashTag: String, colorContent: UIColor = UIColor(netHex: 0x758692)){
        let attributedString = NSMutableAttributedString()
        let words:[String] = contentWithHashTag.separate(withChar: " ")
        let fontContentFamily = UIFont(name: "OpenSans-Regular", size: 15) ?? UIFont.systemFont(ofSize: 15)
        let fontUserNameFamily = UIFont(name: "OpenSans-Semibold", size: 15) ?? UIFont.systemFont(ofSize: 15)
        for i in 0 ..< words.count {
            if words[i].trimmingCharacters(in: .whitespaces).prefix(1) == "#" && words[i].count > 1{
                attributedString.append(NSAttributedString(string: words[i], attributes: [
                    NSAttributedString.Key.link : "mention://\(words[i].trimmingCharacters(in: .whitespaces).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")",
                    NSAttributedString.Key.foregroundColor : UIColor(netHex: 0x157EFB), NSAttributedString.Key.font : fontUserNameFamily
                    ]))
            } else {
                attributedString.append(NSAttributedString(string: words[i], attributes: [
                    NSAttributedString.Key.foregroundColor : colorContent, NSAttributedString.Key.font : fontContentFamily
                    ]))
            }
        }
        self.attributedText = attributedString
        
    }
}
