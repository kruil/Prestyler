//
//  Precolor.swift
//  Pods-Prestyler_Example
//
//  Created by Ilya Krupko on 01/03/2019.
//

import Foundation


public class Precolor {
    private let color: UIColor
    var isForeground = true
    var random: Int = 0

    var colorToApply: UIColor {
        if random == 0 {
            return color
        }
        return color.mixin(infusion: randomColor(), alpha: CGFloat(Double(random) / 100))
    }

    //MARK: - Public methods

    public init() {
        color = UIColor.red
        random = 100
    }

    public init(_ color: UIColor) {
        self.color = color
    }

    public init(_ hexString: String) {
        self.color = hexStringToUIColor(hex: hexString) ?? Constants.errorColor
    }

    public func forBackgound() -> Precolor {
        isForeground = false
        return self
    }

    public func random(_ percent: Int = 100) -> Precolor {
        self.random = percent
        return self
    }

    //MARK: - Private methods

    func randomColor() -> UIColor {
        let hue : CGFloat = CGFloat(arc4random() % 256) / 256 // use 256 to get full range from 0.0 to 1.0
        let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from white
        let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from black
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
}

extension UIColor {
    func mixin(infusion: UIColor, alpha: CGFloat) -> UIColor {
        let alpha2 = min(1.0, max(0, alpha))
        let beta = 1.0 - alpha2

        var r1:CGFloat = 0, r2:CGFloat = 0
        var g1:CGFloat = 0, g2:CGFloat = 0
        var b1:CGFloat = 0, b2:CGFloat = 0
        var a1:CGFloat = 0, a2:CGFloat = 0
        if getRed(&r1, green: &g1, blue: &b1, alpha: &a1) &&
            infusion.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        {
            let red     = r1 * beta + r2 * alpha2;
            let green   = g1 * beta + g2 * alpha2;
            let blue    = b1 * beta + b2 * alpha2;
            let alpha   = a1 * beta + a2 * alpha2;
            return UIColor(red: red, green: green, blue: blue, alpha: alpha)
        }
        return self
    }
}
