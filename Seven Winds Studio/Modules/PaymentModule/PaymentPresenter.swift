//
//  PaymentPresenter.swift
//  Seven Winds Studio
//
//  Created by Jam Mardonov on 10/11/24.
//  
//

import Foundation

final class PaymentPresenter: ViewToPresenterPaymentProtocol {
    // MARK: Properties
    weak var view: PresenterToViewPaymentProtocol?
    internal var interactor: PresenterToInteractorPaymentProtocol?
    internal var router: PresenterToRouterPaymentProtocol?
}

extension PaymentPresenter: InteractorToPresenterPaymentProtocol {
    
}
