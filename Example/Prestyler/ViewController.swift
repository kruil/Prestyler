//
//  ViewController.swift
//  Prestyler
//
//  Created by kruil on 02/28/2019.
//  Copyright (c) 2019 kruil. All rights reserved.
//

import UIKit
import Prestyler


class ViewController: UIViewController {
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label6: UILabel!
    @IBOutlet weak var label7: UILabel!
    @IBOutlet weak var label8: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // use predefined rules:
        label1.attributedText = "<b>Hello world!<b> I'm <underline>Prestyler<underline>.".prestyled()

        // or define your owns:
        Prestyler.defineRule("$", 32, UIColor.orange, Prestyle.italic)
        label2.attributedText = "Style $text$ in an <bi>easy<bi> way.".prestyled()

        Prestyler.defineRule("<yellowOnBlue>", UIColor.blue, Prestyle.bold)
        label3.attributedText = "<yellowOnBlue> Quick and free<yellowOnBlue> for use.".prestyled()

        // Use Precolor class to set foreground and backgound colors
        Prestyler.defineRule("<coolgreen>", Precolor("#550"), Precolor("#a7f442").forBackgound())
        label4.attributedText = "Custom <coolgreen>colors<coolgreen> and different rules.".prestyled()

        Prestyler.defineRule("<mixed>", Precolor(.red).random(50), 42)
        Prestyler.defineRule("<random>", "#fff", Precolor().random().forBackgound(), 42)
        label5.attributedText = "<mixed>Create cool<mixed> <random>effects<random>".prestyled()

        // Filter what you need and style it
        Prestyler.defineRule("*", UIColor.red)
        Prestyler.defineRule("^", UIColor.blue)
        let text = "Highlight text or numbers like 23 or 865 in your text using Prefilter. " +
                   "It parses your text, embrace numbers 73 and 1234, and you are ready to go."
        let prefilteredText = text.prefilter(type: .numbers, by: "*").prefilter(keyword: "text", by: "^")
        label6.attributedText = prefilteredText.prestyled()

        // You can easy style any text without tags by rule name or style list
        label7.attributedText = "Short and simple syntax.".prestyledBy(rule: "<b>")
        label8.attributedText = "You will like it! ❤️ ".prestyledBy(styles: "#e38", Prestyle.bold)

    }
}

