//
//  UnderlinedLabel.swift
//  Machinestalk
//
//  Created by Adel on 2/22/23.
//

import Foundation
import UIKit

class UnderlinedLabel: UILabel {

override var text: String? {
    didSet {
        guard let text = text else { return }
        let textRange = NSMakeRange(0, text.count)
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: textRange)
        attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: textRange)

        NSAttributedString.Key.foregroundColor
        // Add other attributes if needed
        self.attributedText = attributedText
        }
    }
    
    func clearStyle() {
        guard let text = text else { return }
        self.attributedText =   NSAttributedString(string: text, attributes: nil)
    }
}
