//
//  RKLoadingIndicatorView.swift
//  Develop
//
//  Created by ManhLD on 08/01/2021.
//

import Foundation
import UIKit

class LoadingIndicatorView: UIView {
    
    @IBOutlet weak var imvLoading: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    class func loading(parent: UIView? = AppDelegate.shared.window, backgroundColor: UIColor = UIColor.black.withAlphaComponent(0.4)) -> LoadingIndicatorView {
        let loadingView: LoadingIndicatorView = LoadingIndicatorView.loadFromNib(name: "RKLoadingIndicatorView")
        parent?.addSubview(loadingView)
        loadingView.backgroundColor = backgroundColor
        loadingView.fitParent()
        loadingView.imvLoading.rotate(duration: 1.2)
        loadingView.showLoading(duration: 0.5)
        return loadingView
    }
    
    func hidden(removeFromParent: Bool) {
        hide(animation: true, duration: 0.35) {
            self.imvLoading.layer.removeAllAnimations()
            self.removeFromSuperview()
        }
    }
}

