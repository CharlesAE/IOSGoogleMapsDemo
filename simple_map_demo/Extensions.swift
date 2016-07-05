//
//  Extensions.swift
//  simple_map_demo
//
//  Created by Charles E on 7/5/16.
//  Copyright © 2016 SR Studios. All rights reserved.
//

import UIKit

extension UIView {
    func addConstraintsWFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerate() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

