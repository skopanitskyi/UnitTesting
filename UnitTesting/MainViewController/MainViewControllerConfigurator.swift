//
//  MainViewControllerConfigurator.swift
//  UnitTesting
//
//  Created by Сергей Копаницкий on 28.06.2021.
//

import Foundation
import UIKit

struct MainViewControllerConfigurator {
    static func configure() -> MainViewController {
        let viewController = MainViewController()
        let presenter = MainViewPresenter(controller: viewController)
        viewController.presenter = presenter
        return viewController
    }
}
