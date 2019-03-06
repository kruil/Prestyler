//
//  Precolor.swift
//  Pods-Prestyler_Example
//
//  Created by Ilya Krupko on 01/03/2019.
//

import Foundation


/// Precolor helps to manage color information for Rule styles. By using precolor you can define background and foreground text colors, and also make some interesting effects.
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

    /// Initialize new Precolor with random color
    public init() {
        color = UIColor.red
        random = 100
    }

    /// Initialize new Precolor with provided color
    public init(_ color: UIColor) {
        self.color = color
    }

    /// Initialize new Precolor with provided string color in hex format. For example "#234" or "#5463ff"
    public init(_ hexString: String) {
        self.color = hexString.hexToUIColor() ?? Constants.errorColor
    }

    /// Precolor will effect to background text color instead of foreground.
    public func forBackgound() -> Precolor {
        isForeground = false
        return self
    }

    /// Set percent which defines how much random color should effect original color.
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
