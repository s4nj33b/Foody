//
//  View.swift
//  Foody
//
//  Created by Sanjeeb on 14/04/21.
//

import UIKit

public extension UIView {
    @IBInspectable var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
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
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}

@IBDesignable open class NibView: UIView {
    
    @IBInspectable public var contentXib: String? {
        didSet {
            try? didUpdateXib()
        }
    }
    open var contentView: UIView?
    
    func didUpdateXib() throws {
        contentView?.removeFromSuperview()
        guard let name = contentXib else {
            return
        }
        try contentView = addXibAsSubView(xib: name)
        contentViewAdded()
    }
    
    open func contentViewAdded() {
    }
}

public extension UIView {
    func addXibAsSubView(xib: String) throws -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: xib, bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            return UIView()
        }
        _ = addFitting(subView: view)
        return view
    }
    
    
    func addFitting(subView: UIView) -> (left: NSLayoutConstraint, right: NSLayoutConstraint, top: NSLayoutConstraint, bottom: NSLayoutConstraint) {
        addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false
        return UIView.stickViewEdges(view1: self, view2: subView)
    }
    
    static func stickViewEdges(view1: UIView, view2: UIView) -> (left: NSLayoutConstraint, right: NSLayoutConstraint, top: NSLayoutConstraint, bottom: NSLayoutConstraint) {
        
        let left = NSLayoutConstraint(item: view2, attribute: .left, relatedBy: .equal, toItem: view1, attribute: .left, multiplier: 1.0, constant: 0.0)
        let right = NSLayoutConstraint(item: view2, attribute: .right, relatedBy: .equal, toItem: view1, attribute: .right, multiplier: 1.0, constant: 0.0)
        let top = NSLayoutConstraint(item: view2, attribute: .top, relatedBy: .equal, toItem: view1, attribute: .top, multiplier: 1.0, constant: 0.0)
        let bottom = NSLayoutConstraint(item: view2, attribute: .bottom, relatedBy: .equal, toItem: view1, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        
        NSLayoutConstraint.activate([left, right, top, bottom])
        return (left: left, right: right, top: top, bottom: bottom)
    }
}
extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
    }
}
extension UIView {
    func removeAllSubviews() {
        subviews.forEach {
            $0.removeFromSuperview()
        }
    }
}
