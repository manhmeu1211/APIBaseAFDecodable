//
//  UIViewControllerExt.swift
//  BaseAFAPI
//
//  Created by ManhLD on 11/3/20.
//

import Foundation
import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        // this pulls out "MyApp.MyViewController"
        let fullName = NSStringFromClass(self)
        
        // this splits by the dot and uses everything after, giving "MyViewController"
        let className = fullName.components(separatedBy: ".")[1]
        
        // loaded our storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // instantiate a view controller with that identifier, and force cast as the type that was requested.
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
        
        
    }
}


extension UIViewController {
    
    func topController(controller: UIViewController? = UIApplication.shared.windows.first?.rootViewController) -> UIViewController {
        if let navigationController = controller as? UINavigationController {
            return topController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topController(controller: presented)
        }
        return controller ?? UIViewController()
    }
}

extension UIViewController {
    
    func instantiateViewController<T>(fromStoryboard name: StoryboardName, ofType type: T.Type) -> T {
        return UIStoryboard(name: name.rawValue, bundle: nil).instantiateViewController(ofType: type)
    }
}

extension UIViewController {
    
    static func instantiateViewController<T>(fromStoryboard name: StoryboardName, ofType type: T.Type) -> T {
        return UIStoryboard(name: name.rawValue, bundle: nil).instantiateViewController(ofType: type)
    }
}

enum StoryboardName: String {
    case home = "Main"
}

extension UIStoryboard {
    func instantiateViewController<T>(ofType type: T.Type) -> T {
        return instantiateViewController(withIdentifier: String(describing: type)) as! T
    }
}


extension UIViewController {
    
    var className: String {
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
    }
    
    
    func pop(animated: Bool = true, checkInput: Bool = false) {
        navigationController?.popViewController(animated: animated)
    }
    
    func popToRoot(animated: Bool = true, checkInput: Bool = false) {
        navigationController?.popToRootViewController(animated: animated)
    }
    
    func pop(to: UIViewController, animated: Bool = true, checkInput: Bool = false) {
        navigationController?.popToViewController(to, animated: animated)
    }
    
    func push(to viewController: UIViewController, animated: Bool = true) {
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func present(to viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .overCurrentContext
        present(viewController, animated: animated, completion: completion)
    }
}

extension UIViewController {
    func pushWith(subtype: CATransitionSubtype = .fromTop, animated: Bool = false, to viewController: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = subtype
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        self.push(to: viewController, animated: animated)
    }
    
    func popWith(subtype: CATransitionSubtype = .fromBottom, animated: Bool = false) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = subtype
        self.navigationController?.view.layer.add(transition, forKey: nil)
        self.pop(animated: animated)
    }
}




extension UIView {
  
    class func nib(name: String) -> UINib {
        return UINib(nibName: name, bundle: nil)
    }
    
    class func loadFromNib<T: UIView>(name: String) -> T {
        return Bundle.main.loadNibNamed(name, owner: nil, options: nil)![0] as! T
    }
    
    func fitParent(padding: UIEdgeInsets = .zero) {
        
        guard let parent = self.superview else {
            return
        }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: parent, attribute: .top, multiplier: 1, constant: padding.top),
            NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: parent, attribute: .left, multiplier: 1, constant: padding.left),
            NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: parent, attribute: .bottom, multiplier: 1, constant: padding.bottom),
            NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: parent, attribute: .right, multiplier: 1, constant: padding.right)
        ])
    }
}


extension UIView {
    //Hide a view with default animation
    func hide(animation: Bool = true, duration: TimeInterval = 0.3, completion: (() -> ())? = nil) {
        //allway update UI on mainthread
        DispatchQueue.main.async {
            
            if !animation || self.isHidden {
                self.isHidden = true
                completion?()
                return
            }
            
            let currentAlpha = self.alpha
            
            UIView.animate(withDuration: duration, animations: {
                self.alpha = 0
            }, completion: { (success) in
                self.isHidden = true
                self.alpha = currentAlpha
                completion?()
            })
        }
    }
    
    //Show a view with animation
    func showLoading(animation: Bool = true, duration: TimeInterval = 0.3, completion: (() -> ())? = nil) {
        
        //allway update UI on mainthread
        DispatchQueue.main.async {
            
            if !animation || !self.isHidden {
                self.isHidden = false
                completion?()
                return
            }
            
            let currentAlpha = self.alpha
            self.alpha = 0.05
            self.isHidden = false
            
            UIView.animate(withDuration: duration, animations: {
                self.alpha = currentAlpha
            }, completion: { (success) in
                completion?()
            })
        }
    }
    
    //rotate view 3D with Z
    func rotate(duration: CFTimeInterval = 0.8, toValue: Any = Float.pi*2, repeatCount: Float = Float.infinity, removeOnCompleted: Bool = false) {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.duration = duration
        animation.toValue = toValue
        animation.repeatCount = repeatCount
        animation.isRemovedOnCompletion = removeOnCompleted
        layer.add(animation, forKey: "rotate")
    }
    
    // Remove rotate animation
    func stopRotate() {
        layer.removeAnimation(forKey: "rotate")
    }
    
    //MARK: - AddConstraint with Visual Format Language
    func addConstraintWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format,
                                                      options: NSLayoutConstraint.FormatOptions(),
                                                      metrics: nil, views: viewsDictionary))
    }
    
    func setHide(hidden: Bool, duration: TimeInterval) {
        UIView.transition(with: self, duration: duration, options: .transitionCrossDissolve, animations: {
            self.alpha = hidden ? 0 : 1
        })
    }
}
