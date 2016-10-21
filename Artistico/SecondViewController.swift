//
//  SecondViewController.swift
//  Artistico
//
//  Created by Michael Muinos on 10/19/16.
//  Copyright © 2016 Michael Muinos. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    @IBOutlet weak var alphaLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func redSliderChanged(_ sender: UISlider) {
        let value = sender.value
        redLabel.text = "\(value)"
    }

    @IBAction func greenSliderChanged(_ sender: UISlider) {
        let value = sender.value
        greenLabel.text = "\(value)"
    }
    
    @IBAction func blueSliderChanged(_ sender: UISlider) {
        let value = sender.value
        blueLabel.text = "\(value)"
    }
    
    @IBAction func alphaSliderChanged(_ sender: UISlider) {
        let value = sender.value
        alphaLabel.text = "\(value)"
    }
    
}

