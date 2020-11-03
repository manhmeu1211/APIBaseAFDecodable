//
//  Fonts.swift
//  BaseAFAPI
//
//  Created by ManhLD on 11/3/20.
//

import Foundation
import UIKit

struct Fonts {
    
    enum SFUIDisplay: String {
        case regular = "SFUIDisplay-Regular"
        case bold = "SFUIDisplay-Bold"
        case medium = "SFUIDisplay-Medium"
        case semiBold = "SFUIDisplay-SemiBold"
        
        func size(_ size: CGFloat) -> UIFont {
            return UIFont(name: self.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
        }
    }
    
    static func with(style: SFUIDisplay, size: CGFloat) -> UIFont {
        return UIFont(name: style.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
