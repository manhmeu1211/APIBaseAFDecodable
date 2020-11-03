//
//  StringExt.swift
//  BaseAFAPI
//
//  Created by ManhLD on 11/3/20.
//

import Foundation
import UIKit

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    var isEmail : Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func getEmailNameFromEmail() -> String{
        if self.isEmail {
            let index2 = self.range(of: "@", options: .backwards)?.lowerBound
            return index2.map(self.substring(to:))!
        } else {
            return ""
        }
    }
    
    func makeTappableString(with size: CGFloat) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttribute(.font, value: Fonts.with(style: .regular, size: size), range: (self as NSString).range(of: self))
        
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let matches = detector.matches(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count))

        for match in matches {
            guard let range = Range(match.range, in: self) else { continue }
            attributedString.addAttribute(.link, value: self[range], range: match.range)
        }
        
        return attributedString
    }
    
    func getHtmlAttributedString(fontSize: Int, fontFamily: String) -> NSMutableAttributedString {
        let modifiedFont = String(format:"<span style=\"font-family: '-apple-system', '\(fontFamily)'; font-size: \(fontSize)\">%@</span>", self)
        guard let data = modifiedFont.data(using: .utf8) else { return NSMutableAttributedString() }
        do {
            return try NSMutableAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            return NSMutableAttributedString()
        }
    }
}
