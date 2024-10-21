//
//  Ext + UIView.swift
//  MVP+Router
//
//  Created by NikitaKorniuk   on 21.10.24.
//

import UIKit

extension UIView {
    func add(subviews: UIView...) {
        for subview in subviews {
            self.addSubview(subview)
        }
    }
}
