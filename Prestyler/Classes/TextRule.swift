//
//  TextRule.swift
//  Prestyler
//
//  Created by Ilya Krupko on 28/02/2019.
//

import Foundation


struct TextRule {
    let styles: [Any]
    var positions: [Int]

    var color: UIColor? {
        for style in styles where style is UIColor {
            return style as? UIColor
        }
        for style in styles where style is String {
            if  let hexString = style as? String,
                let color = hexString.hexToUIColor() {
                return color
            }
        }
        return nil
    }

    var font: UIFont? {
        for style in styles where style is UIFont {
            return style as? UIFont
        }
        return nil
    }

    var fontSize: CGFloat {
        // if defined explicitly by Int return
        for style in styles where style is Int {
            return CGFloat(style as! Int)
        }
        // or retrieve from font
        if let font = font {
            return font.pointSize
        }
        return CGFloat(Prestyler.defaultFontSize)
    }

    mutating func correctPositions(offsets: [(Int, Int, Int)]) {
        var result = [Int]()
        for offset in offsets {
            let oldValue = offset.0
            let diff = offset.1
            let maxValue = offset.2
            for pos in positions where pos > oldValue && pos < maxValue {
                result.append(pos + diff)
            }
        }
        positions = result
    }

    func applyTo(text: inout NSMutableAttributedString) {
        // calculate ranges
        let ranges = getRangesFromPositions(maxPosition: text.length - 1)
        // apply
        for range in ranges {
            // colors
            if let color = self.color {
                text.addAttribute(NSAttributedString.Key.foregroundColor,
                                  value: color,
                                  range: range)
            }
            for style in styles {
                if let precolor = style as? Precolor {
                    let type: NSAttributedString.Key = precolor.isForeground ? .foregroundColor : .backgroundColor
                    let ranges = precolor.random == 0 ? [range] : range.splitUnitary()
                    for range in ranges {
                        text.addAttribute(type, value: precolor.colorToApply, range: range)
                    }
                }
            }
            // font and size
            if styles.contains(where: { $0 is Int }) {
                text.addAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)], range: range)
            }
            if styles.contains(where: { $0 as? Prestyle == .bold }) {
                text.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize)], range: range)
            }
            if styles.contains(where: { $0 as? Prestyle == .italic }) {
                text.addAttributes([NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: fontSize)], range: range)
            }
            if let font = font {
                text.addAttributes([NSAttributedString.Key.font: font], range: range)
            }
            // other properties
            if styles.contains(where: { $0 as? Prestyle == .strikethrough }) {
                text.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: range)
            }
            if styles.contains(where: { $0 as? Prestyle == .underline }) {
                text.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
            }
        }
    }

    fileprivate func getRangesFromPositions(maxPosition: Int) -> [NSRange] {
        var positions = self.positions
        var ranges = [NSRange]()
        while positions.count > 0 {
            if positions.count == 1 {
                ranges.append(NSRange(location: positions[0], length: maxPosition))
                positions =  Array(positions.dropFirst())
            }
            if positions.count > 1 {
                ranges.append(NSRange(location: positions[0], length: positions[1] - positions[0]))
                positions =  Array(positions.dropFirst(2))
            }
        }
        return ranges
    }
}
