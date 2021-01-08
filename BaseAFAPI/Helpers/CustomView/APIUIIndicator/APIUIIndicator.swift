//
//  APIUIIndicator.swift
//  Develop
//
//  Created by ManhLD on 08/01/2021.
//

import UIKit

// MARK: - Handle UI events
class APIUIIndicator {
    
    public static var loadingView: RKLoadingIndicatorView?
    
    static func showIndicator() {
        // Write your code to show your own indicator
        // Example:
        if APIUIIndicator.loadingView == nil {
            APIUIIndicator.loadingView = LoadingIndicatorView.loading()
        }
    }
    
    static func showIndicator(_ parent: UIView, backgroundColor: UIColor = UIColor.black.withAlphaComponent(0.4)) {
        // Write your code to show your own indicator
        // Example:
        if APIUIIndicator.loadingView == nil {
            APIUIIndicator.loadingView = LoadingIndicatorView.loading(parent: parent, backgroundColor: backgroundColor)
        }
    }
    
    static func hideIndicator() {
        // Write your code to hide your own indicator
        // Example:
        APIUIIndicator.loadingView?.hidden(removeFromParent: true)
        APIUIIndicator.loadingView = nil
    }
}
