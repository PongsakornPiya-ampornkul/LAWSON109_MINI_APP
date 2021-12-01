//
//  Loading.swift
//  LAWSON109_MINI_APP
//
//  Created by Pongsakorn Piya-ampornkul on 30/11/2564 BE.
//

import UIKit

class Loading {
    static let fade = 0.1
    static var indicator: UIView = {
        var view = UIView()
        let screen: CGRect = UIScreen.main.bounds
        var side = screen.width / 4
        var x = (screen.width / 2) - (side / 2)
        var y = (screen.height / 2) - (side / 2)
        view.frame = CGRect(x: x, y: y, width: side, height: side)
        view.layer.cornerRadius = 10
        view.alpha = 0.0
        view.tag = 1
        let image = UIImage(named: "load-icon-png")
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: side / 4, y: side / 4, width: side / 2, height: side / 2)
        view.addSubview(imageView)
        return view
    }()
    
    static var animation: CABasicAnimation = {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2.0)
        rotateAnimation.duration = 2.0
        rotateAnimation.repeatCount = Float.infinity
        return rotateAnimation
    }()
    
    static func start () {
        if let window: UIWindow = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first {
            var found: Bool = false
            for subview in window.subviews {
                if subview.tag == 1 {
                    found = true
                }
            }
            if !found {
                for subview in indicator.subviews {
                    subview.layer.add(animation, forKey: nil)
                }
                window.addSubview(indicator)
                UIView.animate(withDuration: fade, animations: {
                    self.indicator.alpha = 1.0
                })
            }
        }
    }
    
    static func stop () {
        UIView.animate(withDuration: fade, animations: {
            self.indicator.alpha = 0.0
        }, completion: { (value: Bool) in
            self.indicator.removeFromSuperview()
            for subview in self.indicator.subviews {
                subview.layer.removeAllAnimations()
            }
        })
    }
}
