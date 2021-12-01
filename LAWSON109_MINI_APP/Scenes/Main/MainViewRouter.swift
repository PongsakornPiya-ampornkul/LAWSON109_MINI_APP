//
//  MainViewRouter.swift
//  LAWSON109_MINI_APP
//
//  Created by Pongsakorn Piya-ampornkul on 26/11/2564 BE.
//

import Foundation

protocol MainViewRouterProtocol {
    
}

protocol MainViewDataPassing {
    var dataStore: MainViewDataStore? { get }
}

class MainViewRouter: MainViewDataPassing {
    private weak var viewController: MainViewController?
    var dataStore: MainViewDataStore?
    static let shared = MainViewRouter()
    func createModule() -> MainViewController {
        let viewController = MainViewController()
        let interactor = MainViewInteractor()
        let presenter = MainViewPresenter()
        interactor.presenter = presenter
        presenter.view = viewController
        viewController.interactor = interactor
        viewController.router = self
        self.dataStore = interactor
        self.viewController = viewController
        return viewController
    }
}

extension MainViewRouter: MainViewRouterProtocol {
    
}
