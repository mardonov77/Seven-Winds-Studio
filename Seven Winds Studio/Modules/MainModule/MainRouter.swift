//
//  MainRouter.swift
//  Seven Winds Studio
//
//  Created by Jam Mardonov on 07/11/24.
//  
//

import Foundation
import UIKit

final class MainRouter: PresenterToRouterMainProtocol {
   
    static func createModule() -> MainViewController {
        let viewController = MainViewController()
        let presenter: ViewToPresenterMainProtocol & InteractorToPresenterMainProtocol = MainPresenter()

        viewController.presenter = presenter
        viewController.presenter?.router = MainRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = MainInteractor()
        viewController.presenter?.interactor?.presenter = presenter

        return viewController
    }

    func navigateToMenuModule(from view: PresenterToViewMainProtocol, with id: Int) {
        guard let viewController = view as? UIViewController else { return }
        let menuVC = MenuRouter.createModule(with: id)
        viewController.navigationController?.pushViewController(menuVC, animated: true)
    }
    
    func navigateToMapScreen(from view: PresenterToViewMainProtocol, with locations: [LocationsResponse]) {
        guard let viewController = view as? UIViewController else { return }
        let mapVC = MapRouter.createModule(with: locations)
        viewController.navigationController?.pushViewController(mapVC, animated: true)
    }
}
