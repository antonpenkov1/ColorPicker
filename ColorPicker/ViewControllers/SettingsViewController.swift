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
    
    // MARK: - View Life Cycle and overrided methods
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = 16
        updateColor()
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        redTextField.text = String(format: "%.2f", redValue)
        greenTextField.text = String(format: "%.2f", greenValue)
        blueTextField.text = String(format: "%.2f", blueValue)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

    // MARK: - IBAction
    @IBAction func sliderAction(_ sender: UISlider) {
        setViewColor()
        
        switch sender {
        case redSlider:
            redLabel.text = String(format: "%.2f", redSlider.value)
            redValue = redSlider.value
            redTextField.text = redLabel.text
        case greenSlider:
            greenLabel.text = String(format: "%.2f", greenSlider.value)
            greenValue = greenSlider.value
            greenTextField.text = greenLabel.text
        default:
            blueLabel.text = String(format: "%.2f", blueSlider.value)
            blueValue = blueSlider.value
            blueTextField.text = blueLabel.text
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
        updateRed()
        updateGreen()
        updateBlue()
        
        setViewColor()
    }
    
    private func updateRed() {
        redSlider.value = redValue
        redLabel.text = String(format: "%.2f", redValue)
    }
    
    private func updateGreen() {
        greenSlider.value = greenValue
        greenLabel.text = String(format: "%.2f", greenValue)
    }
    
    private func updateBlue() {
        blueSlider.value = blueValue
        blueLabel.text = String(format: "%.2f", blueValue)
    }
    
    private func showAlert(
        withTitle title: String,
        andMessage message: String,
        completion: (() -> Void)? = nil
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
}

// MARK: - UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case redTextField:
            redValue = Float(redTextField.text ?? "0")
            guard redValue >= 0.0, redValue <= 1.0 else {
                showAlert(
                    withTitle: "Wrong format!",
                    andMessage: "Please enter correct value"
                ) {
                    self.redTextField.text = self.redLabel.text
                    self.redValue = self.redSlider.value
                }
                return
            }
            updateRed()
        case greenTextField:
            greenValue = Float(greenTextField.text ?? "0")
            guard greenValue >= 0.0, greenValue <= 1.0 else {
                showAlert(
                    withTitle: "Wrong format!",
                    andMessage: "Please enter correct value"
                ) {
                    self.greenTextField.text = self.greenLabel.text
                    self.greenValue = self.greenSlider.value
                }
                return
            }
            updateGreen()
        default:
            blueValue = Float(blueTextField.text ?? "0")
            guard blueValue >= 0.0, blueValue <= 1.0 else {
                showAlert(
                    withTitle: "Wrong format!",
                    andMessage: "Please enter correct value"
                ) {
                    self.blueTextField.text = self.blueLabel.text
                    self.blueValue = self.blueSlider.value
                }
                return
            }
            updateBlue()
        }
        setViewColor()
    }
}
