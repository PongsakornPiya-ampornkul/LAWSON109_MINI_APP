//
//  ReuseIdentifying.swift
//  LAWSON109_MINI_APP
//
//  Created by Pongsakorn Piya-ampornkul on 26/11/2564 BE.
//

import Foundation
import UIKit

public protocol ReuseIdentifying {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifying {
    public static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UIViewController: ReuseIdentifying {
    
}

extension UIView: ReuseIdentifying { }
