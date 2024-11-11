//
//  LoginRouter.swift
//  Seven Winds Studio
//
//  Created by Jam Mardonov on 02/11/24.
//
//

import UIKit

final class LoginRouter: PresenterToRouterLoginProtocol {
    
    static func createModule() -> LoginViewController {
        let viewController = LoginViewController()
        
        let presenter: ViewToPresenterLoginProtocol & InteractorToPresenterLoginProtocol = LoginPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = LoginRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = LoginInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
    internal func navigateToMainScreen(from view: PresenterToViewLoginProtocol) {
        guard let viewController = view as? UIViewController else { return }
        let menuVC = MainRouter.createModule()
        viewController.navigationController?.pushViewController(menuVC, animated: true)
    }
}
