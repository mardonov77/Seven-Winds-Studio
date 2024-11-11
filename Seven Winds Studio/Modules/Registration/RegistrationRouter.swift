//
//  RegistrationRouter.swift
//  Seven Winds Studio
//
//  Created by Jam Mardonov on 02/11/24.
//  
//

import UIKit

final class RegistrationRouter: PresenterToRouterRegistrationProtocol {
    static func createModule() -> RegistrationViewController {
        let viewController = RegistrationViewController()
        
        let presenter: ViewToPresenterRegistrationProtocol & InteractorToPresenterRegistrationProtocol = RegistrationPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = RegistrationRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = RegistrationInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
    internal func navigateToSuccessScreen(from view: PresenterToViewRegistrationProtocol) {
        guard let viewController = view as? UIViewController else { return }
        let menuVC = LoginRouter.createModule()
        viewController.navigationController?.pushViewController(menuVC, animated: true)
    }
}
