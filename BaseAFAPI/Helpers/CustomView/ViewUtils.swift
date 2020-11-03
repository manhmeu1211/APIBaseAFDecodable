//
//  ViewUtils.swift
//  BaseAFAPI
//
//  Created by ManhLD on 11/3/20.
//

import Foundation
import UIKit

class ViewUtils {
    class func safeAreaInsets() -> UIEdgeInsets {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.window!.safeAreaInsets
    }
}

struct ViewConstants {
    static let headerContentHeight = CGFloat(44)
}
