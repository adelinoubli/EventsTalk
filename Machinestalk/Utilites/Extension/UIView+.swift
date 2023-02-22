//
//  UIView+.swift
//  1MinuteMeteo
//
//  Created by Adel on 1/13/23.
//

import UIKit

extension UIView {
    
    public enum Anchor {
        case left
        case top
        case right
        case bottom
    }
    
    func setFillingConstraints(in container: UIView,
                               anchors: [Anchor] = [.left, .top, .right, .bottom],
                               margins: UIEdgeInsets = UIEdgeInsets.zero) {
        translatesAutoresizingMaskIntoConstraints = false
        for anchor in anchors {
            switch anchor {
            case .left:
                leftAnchor.constraint(equalTo: container.leftAnchor, constant: margins.left).isActive = true
            case .top:
                topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor, constant: margins.top).isActive = true
            case .right:
                rightAnchor.constraint(equalTo: container.rightAnchor, constant: margins.right).isActive = true
            case .bottom:
                bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: margins.bottom).isActive = true
            }
        }
        setNeedsUpdateConstraints()
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat? = 30) {
        switch corners {
        case .bottomLeft:
            layer.maskedCorners = [.layerMinXMaxYCorner]
        case .bottomRight:
            layer.maskedCorners = [.layerMaxXMaxYCorner]
        case .topLeft:
            layer.maskedCorners = [.layerMinXMinYCorner]
        case .topRight:
            layer.maskedCorners = [.layerMaxXMinYCorner]
        default:
            layer.maskedCorners = [.layerMaxXMinYCorner,
                                   .layerMinXMinYCorner]
        }

        if let cornerRadius = radius {
            layer.cornerRadius = cornerRadius
        }
    }
}
