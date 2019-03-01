//
//  StringExtension.swift
//  Pods-Prestyler_Example
//
//  Created by Ilya Krupko on 28/02/2019.
//

import Foundation

public extension String {
    func prestyled() -> NSAttributedString {
        var textToStyle = self
        let appliedRules = Prestyler.findTextRules(&textToStyle)
        var resultedText =  NSMutableAttributedString(string: textToStyle)
        appliedRules.forEach { $0.applyTo(text: &resultedText) }
        return resultedText
    }
}
