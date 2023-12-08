//
//  ViewController.swift
//  ColorPicker
//
//  Created by Антон Пеньков on 17.11.2023.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    var redValue: Float!
    var greenValue: Float!
    var blueValue: Float!
    
    weak var delegate: SettingsViewControllerDelegate?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = 16
        updateColor()
    }

    // MARK: - IBAction
    @IBAction func sliderAction(_ sender: UISlider) {
        setViewColor()
        
        switch sender {
        case redSlider:
            redLabel.text = String(format: "%.2f", redSlider.value)
            redValue = redSlider.value
        case greenSlider:
            greenLabel.text = String(format: "%.2f", greenSlider.value)
            greenValue = greenSlider.value
        default:
            blueLabel.text = String(format: "%.2f", blueSlider.value)
            blueValue = blueSlider.value
        }
    }
    
    @IBAction func doneButtonPressed() {
        delegate?.setColor(
            red: CGFloat(redValue),
            green: CGFloat(greenValue),
            blue: CGFloat(blueValue)
        )
        dismiss(animated: true)
    }
    
    // MARK: - Private Methods
    private func setViewColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func updateColor() {
        redSlider.value = redValue
        greenSlider.value = greenValue
        blueSlider.value = blueValue
        
        redLabel.text = String(format: "%.2f", redSlider.value)
        greenLabel.text = String(format: "%.2f", greenSlider.value)
        blueLabel.text = String(format: "%.2f", blueSlider.value)
        
        setViewColor()
    }
    
}

