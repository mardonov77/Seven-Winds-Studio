//
//  RegistrationContract.swift
//  Seven Winds Studio
//
//  Created by Jam Mardonov on 02/11/24.
//  
//

import Foundation

// MARK: View Output (Presenter -> View)
protocol PresenterToViewRegistrationProtocol: AnyObject {
    func showError(_ message: String)
}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterRegistrationProtocol: AnyObject {
    var view: PresenterToViewRegistrationProtocol? { get set }
    var interactor: PresenterToInteractorRegistrationProtocol? { get set }
    var router: PresenterToRouterRegistrationProtocol? { get set }
    func didTapRegister(login: String, password: String, confirmPassword: String)
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorRegistrationProtocol: AnyObject {
    var presenter: InteractorToPresenterRegistrationProtocol? { get set }
    func registerUser(login: String, password: String)
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterRegistrationProtocol: AnyObject {
    func registrationDidSucceed()
    func registrationDidFail(error: String)
}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterRegistrationProtocol: AnyObject {
    static func createModule() -> RegistrationViewController
    func navigateToSuccessScreen(from view: PresenterToViewRegistrationProtocol)
}
