//
//  UIView+Ext.swift
//  MehilainenAssignment
//
//  Created by Joni Tefke on 1.4.2020.
//  Copyright © 2020 jonitefke. All rights reserved.
//

import UIKit

extension UIView {
    
    func pin(to superView: UIView) {
        translatesAutoresizingMaskIntoConstraints                               = false
        
        let guide = superview!.safeAreaLayoutGuide
        
        topAnchor.constraint(equalTo: guide.topAnchor).isActive             = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive     = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive   = true
        bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive       = true
    }
    
    func center(to superView: UIView) {
        translatesAutoresizingMaskIntoConstraints                               = false
        centerYAnchor.constraint(equalTo: superView.centerYAnchor).isActive     = true
        centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive     = true
    }
}
