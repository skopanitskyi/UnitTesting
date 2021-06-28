//
//  MainViewPresenter.swift
//  UnitTesting
//
//  Created by Сергей Копаницкий on 28.06.2021.
//

import Foundation

protocol MainViewPresenterInput: AnyObject {
    var numberOfRowsInSection: Int { get }
}

class MainViewPresenter {
    
    private let controller: MainViewControllerInput
    
    init(controller: MainViewControllerInput) {
        self.controller = controller
    }
}

// MARK: - MainViewPresenterInput

extension MainViewPresenter: MainViewPresenterInput {
    
    var numberOfRowsInSection: Int {
        return 10
    }
    
}
