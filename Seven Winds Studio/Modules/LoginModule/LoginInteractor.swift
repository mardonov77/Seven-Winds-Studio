//
//  LoginInteractor.swift
//  Seven Winds Studio
//
//  Created by Jam Mardonov on 02/11/24.
//  
//

final class LoginInteractor: PresenterToInteractorLoginProtocol {
    
    // MARK: - Properties
    internal var presenter: InteractorToPresenterLoginProtocol?
    
    func loginUser(login: String, password: String) {
        APIManager.shared.request(.login(login: login, password: password)) { (result: Result<AuthResponse, APIError>) in
            switch result {
            case .success(let response):
                AuthManager.shared.saveToken(response.token, lifetime: response.tokenLifetime)
                self.presenter?.loginDidSucceed(token: response.token)
            case .failure(let error):
                self.presenter?.loginDidFail(error: error.localizedDescription)
            }
        }
    }
}
