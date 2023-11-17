//
//  ViewController.swift
//  ColorPicker
//
//  Created by Антон Пеньков on 17.11.2023.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redComponent: UILabel!
    @IBOutlet var greenComponent: UILabel!
    @IBOutlet var blueComponent: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func redSliderAction() {
    }
    @IBAction func greenSliderAction() {
    }
    @IBAction func blueSliderAction() {
    }
    
}

