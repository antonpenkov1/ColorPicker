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
    
    // !!! Никогда не обращаемся к индексам через квадратные скобки !!!
    // Три элемента не имеют выгоды использовать массивы
    
    // MARK: - Public Properties
    unowned var delegate: SettingsViewControllerDelegate!
    var viewColor: UIColor!
    // unowned (бесхозная ссылка) - при работе со свойствами, которые не могут принимать nil (14 урок)
    
    //    Зачем передавать три свойства, если можно одно
    //    var redValue: Float!
    //    var greenValue: Float!
    //    var blueValue: Float!
    
    //    weak var delegate: SettingsViewControllerDelegate?
    
    // никакие тулбары на уровне класса заводить нельзя
    
    // свойства - это серьезно
    // чем больше параметров - тем сложнее логика
    // на уровне класса только те свойства, к которым должен быть доступ в разных местах, у разных методов
    
    // MARK: - View Life Cycle and overrided methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 16
        
        redSlider.tintColor = .red
        greenSlider.tintColor = .green
        
        colorView.backgroundColor = viewColor
        
        //        redTextField.delegate = self
        //        greenTextField.delegate = self
        //        blueTextField.delegate = self
        
        // здесь важна последовательность вызова методов
        setValue(for: redSlider, greenSlider, blueSlider)
        setValue(for: redLabel, greenLabel, blueLabel)
        setValue(for: redTextField, greenTextField, blueTextField)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - IBAction
    @IBAction func sliderAction(_ sender: UISlider) {
        switch sender {
        case redSlider:
            setValue(for: redLabel)
            setValue(for: redTextField)
        case greenSlider:
            setValue(for: greenLabel)
            setValue(for: greenTextField)
        default:
            setValue(for: blueLabel)
            setValue(for: blueTextField)
        }
        
        setColor()
    }
    
    @IBAction func doneButtonPressed() {
        delegate.setColor(colorView.backgroundColor ?? .white)
        // метод вызывается в том месте, где рождаются данные, там где мы можем их передать
        // в том классе, где инициализирован объект делегата
        dismiss(animated: true)
    }
}
    
    // MARK: - Private Methods
extension SettingsViewController {
    private func setColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    // 18:24 достаточно понять один метод - в этом простота...
    // еще раз посмотреть функции и вариативные параметры в них
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redLabel: label.text = string(from: redSlider)
            case greenLabel: label.text = string(from: greenSlider)
            default: label.text = string(from: blueSlider)
            }
        }
    }
    
    private func setValue(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redLabel: textField.text = string(from: redSlider)
            case greenLabel: textField.text = string(from: greenSlider)
            default: textField.text = string(from: blueSlider)
            }
        }
    }
    
    private func setValue(for colorSliders: UISlider...) {
        let ciColor = CIColor(color: viewColor)
        colorSliders.forEach { slider in
            switch slider {
            case redSlider: redSlider.value = Float(ciColor.red)
            case greenSlider: greenSlider.value = Float(ciColor.green)
            default: blueSlider.value = Float(ciColor.blue)
            }
        }
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func showAlert(withTitle title: String, andMessage message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            textField?.text = "0.05"
            textField?.becomeFirstResponder()
            // этот метод вызывается у текстового поля и он вызывает клавиатуру
            // при нажатии ОК на alert, вызывается клавиатура
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
}

// MARK: - UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        // скрывает клавиатуру по нажатию на done
    }
    // если нет цифровой клавиатуры
    
    // вызывается, когда ... 18:52
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {
            showAlert(withTitle: "Wrong format!", andMessage: "Please enter correct value")
            return
        }
        guard let currentValue = Float(text), (0...1).contains(currentValue) else {
            showAlert(
                withTitle: "Wrong format!",
                andMessage: "Please enter correct value",
                textField: textField
            )
            return
        }
        
        switch textField {
        case redTextField:
            redSlider.setValue(currentValue, animated: true)
            setValue(for: redLabel)
            // setValue позволяет передать значение слайдеру анимировано
        case greenTextField:
            greenSlider.setValue(currentValue, animated: true)
            setValue(for: greenLabel)
        default:
            blueSlider.setValue(currentValue, animated: true)
            setValue(for: blueLabel)
        }
        
        setColor()
    }
    
    // тулбар нужно создавать в textFieldDidBeginEditing
    // он предшествует появлению клавиатуры
    // тулбар не относится к клавиатуре, он относится к текстовому полю
    // он просто пристегивается к клавиатуре
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard textField != redTextField else { return }
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        // устанавливает размер тулбара по размеру клавиатуры
        textField.inputAccessoryView = keyboardToolbar
        // задаем аксессуар к текстовому полю (тулбар)
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: textField,
            // ... 18:49
            action: #selector(resignFirstResponder)
            // синтаксис такой
            // передаем
        )
        
        let flexBarButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            // пространство, занимающее все пустое место, оставшееся от остальных элементов
            target: nil,
            action: nil
        )
        
        keyboardToolbar.items = [flexBarButton, doneButton]
    }
}
