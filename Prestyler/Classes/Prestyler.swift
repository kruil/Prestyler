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
    struct Rule {
        let pattern: String
        var styles: [Any]
    }

    static var defaultFontSize = 18

    static var rules = [
        Rule(pattern: "<b>", styles: [Prestyle.bold]),
        Rule(pattern: "<i>", styles: [Prestyle.italic]),
        Rule(pattern: "<strike>", styles: [Prestyle.strikethrough]),
        Rule(pattern: "<underline>", styles: [Prestyle.underline])
    ]

    // MARK: - Public methods

    static public func newRule(_ pattern: String, _ styles: Any...) {
        rules.removeAll(where: { $0.pattern == pattern })
        rules.append(Rule(pattern: pattern, styles: styles))
    }

    static public func removeAllRules() {
        rules.removeAll()
    }

    // MARK: - Private methods

    static func findTextRules(_ text: inout String) -> [TextRule] {
        var textRules = [TextRule]()
        for rule in rules {
            var positions = text.indexes(of: rule.pattern)
            if positions.count > 0 {
                correctPositions(&positions, rule.pattern.count, &textRules)
                text = text.replacingOccurrences(of: rule.pattern, with: "")
                textRules.append(TextRule(styles: rule.styles, positions: positions))
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
