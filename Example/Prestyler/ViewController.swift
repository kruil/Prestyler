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

    override func viewDidLoad() {
        super.viewDidLoad()

        Prestyler.defineRule("<red>", UIColor.red, Prestyle.bold,  22)
        label1.attributedText = "<red>Hello world!<red> I <strike>am<strike> a <b>cool<b> pod for Swift.".prestyled()

        Prestyler.defineRule("$", UIFont.italicSystemFont(ofSize: 33), UIColor.orange)
        label2.attributedText = "Style $all text$ in an <i>easy way<i>.".prestyled()

        Prestyler.defineRule("<yellowOnBlue>", UIColor.blue, Precolor(.yellow).forBackgound(), Prestyle.bold)
        label3.attributedText = "<yellowOnBlue> Quick <yellowOnBlue> and <underline>free<underline> for use.".prestyled()

        Prestyler.defineRule("<coolgreen>", Precolor("#550"), Precolor("#a7f442").forBackgound())
        Prestyler.defineRule("*", "#f0f")
        label4.attributedText = "Custom <coolgreen>colors<coolgreen> and *different* rules.".prestyled()

        Prestyler.defineRule("<mixed>", Precolor(.red).random(50), 33)
        label5.attributedText = "<mixed>Create cool effects<mixed> ".prestyled()

        Prestyler.defineRule("<random>", "#fff", Precolor().random().forBackgound(), 48)
        label6.attributedText = "Prestyler".prestyledBy(rule: "<random>")
        //§label6.attributedText = "Prestyler".prestyledBy(styles: UIColor.green)
    }
}

