//
//  UIColor.swift
//  Prestyler
//
//  Created by Ilya Krupko on 25.10.2021.
//

extension UIColor {
    func mixin(infusion: UIColor, alpha: CGFloat) -> UIColor {
        let alpha2 = min(1.0, max(0, alpha))
        let beta = 1.0 - alpha2
        var r1:CGFloat = 0, r2:CGFloat = 0
        var g1:CGFloat = 0, g2:CGFloat = 0
        var b1:CGFloat = 0, b2:CGFloat = 0
        var a1:CGFloat = 0, a2:CGFloat = 0
        if getRed(&r1, green: &g1, blue: &b1, alpha: &a1) &&
            infusion.getRed(&r2, green: &g2, blue: &b2, alpha: &a2) {
            let red     = r1 * beta + r2 * alpha2;
            let green   = g1 * beta + g2 * alpha2;
            let blue    = b1 * beta + b2 * alpha2;
            let alpha   = a1 * beta + a2 * alpha2;
            return UIColor(red: red, green: green, blue: blue, alpha: alpha)
        }
        return self
    }
}
