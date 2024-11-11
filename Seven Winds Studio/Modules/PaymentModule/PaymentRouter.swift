//
//  PaymentRouter.swift
//  Seven Winds Studio
//
//  Created by Jam Mardonov on 10/11/24.
//  
//

import Foundation
import UIKit

final class PaymentRouter: PresenterToRouterPaymentProtocol {
    
    // MARK: Static methods
    static func createModule(with selectedItems: [SelectedItem]) -> PaymentViewController {
        
        let viewController = PaymentViewController()
        viewController.items = selectedItems
        
        let presenter: ViewToPresenterPaymentProtocol & InteractorToPresenterPaymentProtocol = PaymentPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = PaymentRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = PaymentInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
}
