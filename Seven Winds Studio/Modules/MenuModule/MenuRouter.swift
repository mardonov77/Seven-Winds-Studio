//
//  MenuRouter.swift
//  Seven Winds Studio
//
//  Created by Jam Mardonov on 09/11/24.
//  
//

import Foundation
import UIKit

final class MenuRouter: PresenterToRouterMenuProtocol {
    
    static func createModule(with locationId: Int) -> MenuViewController {
        let viewController = MenuViewController()
        viewController.locationId = locationId
        
        let presenter: ViewToPresenterMenuProtocol & InteractorToPresenterMenuProtocol = MenuPresenter(locationId: locationId)
        
        viewController.presenter = presenter
        viewController.presenter?.router = MenuRouter()
        viewController.presenter?.view = viewController
        
        let interactor = MenuInteractor()
        interactor.presenter = presenter
        viewController.presenter?.interactor = interactor

        return viewController
    }
    
    func navigateToPayment(from view: PresenterToViewMenuProtocol, with selectedItems: [SelectedItem]) {
        guard let viewController = view as? UIViewController else { return }
        let paymentVC = PaymentRouter.createModule(with: selectedItems)
        viewController.navigationController?.pushViewController(paymentVC, animated: true)
    }
}
