//
//  Prestyler.swift
//  Pods-Prestyler_Example
//
//  Created by Ilya Krupko on 28/02/2019.
//

import Foundation


public enum Prestyle {
    case bold
    case italic
    case strikethrough
    case underline
}


public class Prestyler {
    struct STRule {
        let appliedStyle: [Any]
        let pattern: String
    }

    static var defaultFontSize = 18

    static var rules = [
        STRule(appliedStyle: [Prestyle.bold], pattern: "<b>"),
        STRule(appliedStyle: [Prestyle.italic], pattern: "<i>"),
        STRule(appliedStyle: [Prestyle.strikethrough], pattern: "<strike>"),
        STRule(appliedStyle: [Prestyle.underline], pattern: "<underline>")
    ]

    // MARK: - Public methods

    static public func newRule(_ pattern: String, _ styles: Any...) {
        rules.append(STRule(appliedStyle: styles, pattern: pattern))
    }

    static public func removeAllRules() {
        rules.removeAll()
    }

    // MARK: - Private methods

    static func findTextRules(_ text: inout String) -> [TextRule] {
        var textRules = [TextRule]()
        for r in rules {
            var positions = text.indexes(of: r.pattern)
            if positions.count > 0 {
                correctPositions(&positions, r.pattern.count, &textRules)
                text = text.replacingOccurrences(of: r.pattern, with: "")
                let appliedRule = TextRule(appliedStyle: r.appliedStyle, positions: positions)
                textRules.append(appliedRule)
            }
        }
        return textRules
    }

    fileprivate static func correctPositions(_ positions: inout [Int], _ length: Int, _ existingRules: inout [TextRule]) {
        if positions.count > 0 {
            let oldValue = positions[0]
            let newValue = positions[0] - length
            for index in 0..<existingRules.count {
                existingRules[index].correctPositions(oldValue: oldValue, newValue: newValue)
            }
        }
        for index in 1..<positions.count where index > 0 {
            let oldValue = positions[index]
            let newValue = positions[index] - length * index
            positions[index] = newValue
            for index in 0..<existingRules.count {
                existingRules[index].correctPositions(oldValue: oldValue, newValue: newValue)
            }
        }
    }

    fileprivate static func correctPositionsAccording(_ positions: inout [Int], _ length: Int) {
        for index in 1..<positions.count where index > 0 {
            positions[index] = positions[index] - length * index
        }
    }
}

func hexStringToUIColor(hex: String) -> UIColor? {
    var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    cString = cString.replacingOccurrences(of: "#", with: "")
    if cString.count == 3 {
        let r = cString.character(at: 0) ?? "0"
        let g = cString.character(at: 1) ?? "0"
        let b = cString.character(at: 2) ?? "0"
        cString = "\(r)\(r)\(g)\(g)\(b)\(b)"
    }
    if cString.count != 6 {
        return nil
    }

    var rgbValue: UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
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
