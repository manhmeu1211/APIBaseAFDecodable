//
//  UIImageExt.swift
//  BaseAFAPI
//
//  Created by ManhLD on 11/3/20.
//

import Foundation
import UIKit

extension UIImage {
    func resize(targetSize: CGSize) -> UIImage {
        let size = self.size
        
        let widthRatio  = targetSize.width  / self.size.width
        let heightRatio = targetSize.height / self.size.height
        
        var newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}

var imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func setImageFromUrl(ImageURL :String) {
        if let imageFromCache = imageCache.object(forKey: ImageURL as NSString) {
            self.image = imageFromCache
            return
        }
        guard let url = URL(string: ImageURL) else { return }
        URLSession.shared.dataTask( with: url, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                if let data = data {
                    let imageCached = UIImage(data: data)
                    imageCache.setObject(imageCached ?? UIImage(), forKey: ImageURL as NSString)
                    self.image = imageCached
                }
            }
        }).resume()
    }
    
    func set(color: UIColor) {
        image = image?.withRenderingMode(.alwaysTemplate)
        tintColor = color
    }
    
    func circleImage() {
        layer.masksToBounds = false
        layer.cornerRadius = frame.height/2
        clipsToBounds = true
    }
    
}
