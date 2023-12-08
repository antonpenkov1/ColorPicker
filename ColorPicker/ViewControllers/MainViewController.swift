//
//  MainViewController.swift
//  ColorPicker
//
//  Created by Антон Пеньков on 08.12.2023.
//

import UIKit

protocol SettingsViewControllerDelegate: AnyObject {
    func setColor(red: CGFloat, green: CGFloat, blue: CGFloat)
}

class MainViewController: UINavigationController {
    
    private var redValue: CGFloat = 0.0
    private var greenValue: CGFloat = 0.0
    private var blueValue: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.purple
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let settingsVC = segue.destination as? SettingsViewController
        settingsVC?.delegate = self
        
        settingsVC?.redValue = Float(view.backgroundColor?.redValue ?? 0)
        settingsVC?.greenValue = Float(view.backgroundColor?.greenValue ?? 0)
        settingsVC?.blueValue = Float(view.backgroundColor?.blueValue ?? 0)
    }
    
    private func getColorComponents(for color: UIColor) {
        redValue = color.redValue
        greenValue = color.greenValue
        blueValue = color.blueValue
    }
}

// MARK: - SettingsViewControllerDelegate
extension MainViewController: SettingsViewControllerDelegate {
    func setColor(red: CGFloat, green: CGFloat, blue: CGFloat) {
        view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}

extension UIColor {

    var redValue: CGFloat{
        return cgColor.components! [0]
    }
    
    var greenValue: CGFloat{
        return cgColor.components! [1]
    }

    var blueValue: CGFloat{
        return cgColor.components! [2]
    }

}
