//
//  RegistrationPresenter.swift
//  Seven Winds Studio
//
//  Created by Jam Mardonov on 02/11/24.
//
//

import Foundation

final class RegistrationPresenter: ViewToPresenterRegistrationProtocol {
    
    // MARK: Properties
    internal weak var view: PresenterToViewRegistrationProtocol?
    internal var interactor: PresenterToInteractorRegistrationProtocol?
    internal var router: PresenterToRouterRegistrationProtocol?
    
    func didTapRegister(login: String, password: String, confirmPassword: String) {
        if password.count >= 6 && password == confirmPassword {
            interactor?.registerUser(login: login, password: password)
        } else {
            view?.showError("Пароли не совпадают или слишком короткие")
        }
    }
}

extension RegistrationPresenter: InteractorToPresenterRegistrationProtocol {
    func registrationDidSucceed() {
        AuthManager.shared.setRegistered()
        if let view = view {
            router?.navigateToSuccessScreen(from: view)
        }
    }
    
    func registrationDidFail(error: String) {
        view?.showError(error)
    }
}
