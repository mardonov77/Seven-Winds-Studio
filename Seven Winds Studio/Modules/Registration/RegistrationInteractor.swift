//
//  RegistrationInteractor.swift
//  Seven Winds Studio
//
//  Created by Jam Mardonov on 02/11/24.
//  
//

import Foundation

final class RegistrationInteractor: PresenterToInteractorRegistrationProtocol {
    
    // MARK: Properties
    internal var presenter: InteractorToPresenterRegistrationProtocol?
    
    func registerUser(login: String, password: String) {
        Logger.printLog("Регистрация пользователя с логином: \(login)", status: .success)
        
        APIManager.shared.request(.register(login: login, password: password)) { (result: Result<RegistrationResponse, APIError>) in
            switch result {
            case .success(_):
                Logger.printLog("Регистрация прошла успешно", status: .success)
                self.presenter?.registrationDidSucceed()
            case .failure(let error):
                Logger.printLog("Регистрация не удалась: \(error.localizedDescription)", status: .error)
                self.presenter?.registrationDidFail(error: error.localizedDescription)
            }
        }
    }
}
