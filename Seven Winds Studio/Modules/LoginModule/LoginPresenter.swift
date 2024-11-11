//
//  LoginPresenter.swift
//  Seven Winds Studio
//
//  Created by Jam Mardonov on 02/11/24.
//  
//

final class LoginPresenter: ViewToPresenterLoginProtocol {
   
    // MARK: - Properties
    internal weak var view: PresenterToViewLoginProtocol?
    internal var interactor: PresenterToInteractorLoginProtocol?
    internal var router: PresenterToRouterLoginProtocol?
    
    func didTapLogin(login: String, password: String) {
        if password.count >= 6 {
            interactor?.loginUser(login: login, password: password)
        } else {
            view?.showError("Слишком короткий пароль")
        }
    }
}

extension LoginPresenter: InteractorToPresenterLoginProtocol {
    
    func loginDidSucceed(token: String) {
        AuthManager.shared.saveAuthToken(token)
        if let view = view {
            router?.navigateToMainScreen(from: view)
        }
    }
    
    func loginDidFail(error: String) {
        view?.showError(error)
    }
}
