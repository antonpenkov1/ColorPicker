//
//  ViewController.swift
//  ColorPicker
//
//  Created by Антон Пеньков on 17.11.2023.
//

import UIKit

final class ViewController: UIViewController {
    
// MARK: - Outlets
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    private var redNumber: CGFloat = 0.05
    private var greenNumber: CGFloat = 0.27
    private var blueNumber: CGFloat = 0.49
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = 16
        setViewColor()
    }

    // MARK: - IBActions
    @IBAction func redSliderAction() {
        redNumber = CGFloat(redSlider.value)
        redLabel.text = String(format: "%.2f", redNumber)
        setViewColor()
    }
    @IBAction func greenSliderAction() {
        greenNumber = CGFloat(greenSlider.value)
        greenLabel.text = String(format: "%.2f", greenNumber)
        setViewColor()
    }
    @IBAction func blueSliderAction() {
        blueNumber = CGFloat(blueSlider.value)
        blueLabel.text = String(format: "%.2f", blueNumber)
        setViewColor()
    }
    
    // MARK: - Private Methods
    private func setViewColor() {
        colorView.backgroundColor = UIColor(
            red: redNumber,
            green: greenNumber,
            blue: blueNumber,
            alpha: 1
        )
    }
    
}

