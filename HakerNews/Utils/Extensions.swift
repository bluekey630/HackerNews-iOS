//
//  Extensions.swift
//  HakerNews
//
//  Created by Admin on 2021/8/3.
//

import Foundation
import UIKit
import AVFoundation

extension UIViewController {
    
    func showAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title.capitalizingFirstLetter(), message: msg.capitalizingFirstLetter(), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .`default`, handler: { _ in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    var htmlToAttributedString: NSAttributedString? {
        
        let modifiedFont = String(format: "<span style=\"font-size: 20px\">%@</span>", self)
        guard let data = modifiedFont.data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    func titleStringWith(_ color: UIColor) -> NSMutableAttributedString {
        let attributes = [NSAttributedString.Key.foregroundColor: color, .font: fontForTitle()]
        return NSMutableAttributedString(attributedString: NSAttributedString(string: self, attributes: attributes))
    }

    func urlStringWith(_ color: UIColor) -> NSAttributedString {
        let attributes = [NSAttributedString.Key.foregroundColor: color, .font: fontForURL()]

        return NSAttributedString(string: self, attributes: attributes)
    }

    fileprivate func fontForTitle() -> UIFont {
        return UIFont.systemFont(ofSize: 15)
    }
    
    fileprivate func fontForURL() -> UIFont {
        return UIFont.systemFont(ofSize: 13)
    }
}

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

extension UIScrollView {

    var minContentOffset: CGPoint {
        return CGPoint(
        x: -contentInset.left,
        y: -contentInset.top)
    }

    var maxContentOffset: CGPoint {
        return CGPoint(
        x: contentSize.width - bounds.width + contentInset.right,
        y: contentSize.height - bounds.height + contentInset.bottom)
    }

    func scrollToMinContentOffset(animated: Bool) {
        setContentOffset(minContentOffset, animated: animated)
    }

    func scrollToMaxContentOffset(animated: Bool) {
        setContentOffset(maxContentOffset, animated: animated)
    }
}
