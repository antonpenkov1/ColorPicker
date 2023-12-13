//
//  MainViewController.swift
//  ColorPicker
//
//  Created by Антон Пеньков on 08.12.2023.
//

import UIKit

protocol SettingsViewControllerDelegate: AnyObject {
    func setColor(_ color: UIColor)
    // меньше слов, больше смысла в названиях
    // один объект всегда проще передавать, чем несколько объектов
    // 
}

final class MainViewController: UINavigationController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.delegate = self
        // невозможно инициализировать самим классом делегат, если наш класс
        // не подписан под протокол и не принял тип этого протокола
        settingsVC.viewColor = view.backgroundColor
    }
}

// MARK: - SettingsViewControllerDelegate
extension MainViewController: SettingsViewControllerDelegate {
    // здесь только реализуем метод делегата
    // больше ничего
    func setColor(_ color: UIColor) {
        view.backgroundColor = color
    }
    // метод реализован именно в этом классе ... 18:16
}

// когда пишем код, если работает - порадовались, отдохнули
// потом вернитесь к нему и попробуйте найти как можно больше ошибок
// но только через несколько часов, не сразу, не с замыленными глазами
