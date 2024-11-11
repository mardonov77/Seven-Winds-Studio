//
//  PaymentContract.swift
//  Seven Winds Studio
//
//  Created by Jam Mardonov on 10/11/24.
//  
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewPaymentProtocol: AnyObject {
    func showError(_ message: String)
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterPaymentProtocol: AnyObject {
    
    var view: PresenterToViewPaymentProtocol? { get set }
    var interactor: PresenterToInteractorPaymentProtocol? { get set }
    var router: PresenterToRouterPaymentProtocol? { get set }
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorPaymentProtocol: AnyObject {
    
    var presenter: InteractorToPresenterPaymentProtocol? { get set }
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterPaymentProtocol: AnyObject {
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterPaymentProtocol: AnyObject {
    static func createModule(with selectedItems: [SelectedItem]) -> PaymentViewController
}
