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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // use predefined rules:
        label1.attributedText = "<b>Hello world!<b> I am a cool pod for <underline>Swift<underline>.".prestyled()

        // or define your owns:
        Prestyler.defineRule("$", 28, UIColor.orange, Prestyle.italic)
        label2.attributedText = "Style $text$ in an easy way.".prestyled()

        Prestyler.defineRule("<yellowOnBlue>", UIColor.blue, Prestyle.bold)
        label3.attributedText = "<yellowOnBlue> Quick and free<yellowOnBlue> for use.".prestyled()

        // Use Precolor class to set foreground and backgound colors
        Prestyler.defineRule("<coolgreen>", Precolor("#550"), Precolor("#a7f442").forBackgound())
        label4.attributedText = "Custom <coolgreen>colors<coolgreen> and different rules.".prestyled()

        Prestyler.defineRule("<mixed>", Precolor(.red).random(50), 33)
        Prestyler.defineRule("<random>", "#fff", Precolor().random().forBackgound(), 36)
        label5.attributedText = "<mixed>Create cool<mixed> <random>effects<random>".prestyled()

        // You can easy style any text without tags by rule name or style list
        label6.attributedText = "Short and simple syntax.".prestyledBy(rule: "<b>")
        label7.attributedText = "You will like me! ❤️".prestyledBy(styles: "#e38", Prestyle.bold)
    }
}

