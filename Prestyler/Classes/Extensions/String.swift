//
//  String.swift
//  Prestyler
//
//  Created by Ilya Krupko on 25.10.2021.
//

import Foundation
/// Prestyler uses a public extension to provide access for string formating

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
        (rule + self + rule).prestyled()
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
    private func index(at position: Int, from start: Index? = nil) -> Index? {
        index(start ?? startIndex, offsetBy: position, limitedBy: endIndex)
    }

    private func character(at position: Int) -> Character? {
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
        guard string.count == 6 else {
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
