//
//  StringExtension.swift
//  Pods-Prestyler_Example
//
//  Created by Ilya Krupko on 28/02/2019.
//

import Foundation


/// Prestyler uses a public extension to provide access to string formatting. Next methods can be used for every string.
public extension String {

    /// Convert string to attributed string by looking for embeded tag and find sutable patterns.
    ///
    /// - Returns: Attributed string
    func prestyled() -> NSAttributedString {
        var textToStyle = self
        let appliedRules = Prestyler.findTextRules(&textToStyle)
        var resultedText =  NSMutableAttributedString(string: textToStyle)
        appliedRules.forEach { $0.applyTo(text: &resultedText) }
        return resultedText
    }

    /// Convert string to attributed string by using provided rule pattern.
    ///
    /// - Parameter rule: pattern rule to apply
    /// - Returns: attributed string
    func prestyledBy(rule: String) -> NSAttributedString {
        return (rule + self + rule).prestyled()
    }

    /// Convert string to attributed string by using provided styles.
    ///
    /// - Parameter styles: styles to apply
    /// - Returns: attributed string
    func prestyledBy(styles: Any...) -> NSAttributedString {
        let rule = TextRule(styles: styles, positions: [0, self.count])
        var resultedText =  NSMutableAttributedString(string: self)
        rule.applyTo(text: &resultedText)
        return resultedText
    }
}

extension String {
    func index(at position: Int, from start: Index? = nil) -> Index? {
        let startingIndex = start ?? startIndex
        return index(startingIndex, offsetBy: position, limitedBy: endIndex)
    }

    func character(at position: Int) -> Character? {
        guard position >= 0, let indexPosition = index(at: position) else {
            return nil
        }
        return self[indexPosition]
    }

    func hexToUIColor() -> UIColor? {
        var string = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        string = string.replacingOccurrences(of: "#", with: "")
        if string.count == 3 {
            let r = string.character(at: 0) ?? "0"
            let g = string.character(at: 1) ?? "0"
            let b = string.character(at: 2) ?? "0"
            string = "\(r)\(r)\(g)\(g)\(b)\(b)"
        }
        if string.count != 6 {
            return nil
        }
        var rgbValue: UInt32 = 0
        Scanner(string: string).scanHexInt32(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

extension StringProtocol where Index == String.Index {
    func indexes(of string: Self, options: String.CompareOptions = []) -> [Int] {
        var result: [Int] = []
        var start = startIndex
        while start < endIndex,
            let range = self[start..<endIndex].range(of: string, options: options) {
                result.append(range.lowerBound.encodedOffset)
                start = range.lowerBound < range.upperBound ? range.upperBound :
                    index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
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

extension NSRange {
    func splitUnitary() -> [NSRange] {
        var result = [NSRange]()
        for index in 0..<self.length {
            result.append(NSRange(location: self.location + index, length: 1))
        }
        return result
    }
}
