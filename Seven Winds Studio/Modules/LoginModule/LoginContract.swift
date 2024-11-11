//
//  LoginContract.swift
//  Seven Winds Studio
//
//  Created by Jam Mardonov on 02/11/24.
//  
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewLoginProtocol: AnyObject {
    func showError(_ message: String)
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterLoginProtocol: AnyObject {
    
    var view: PresenterToViewLoginProtocol? { get set }
    var interactor: PresenterToInteractorLoginProtocol? { get set }
    var router: PresenterToRouterLoginProtocol? { get set }
    func didTapLogin(login: String, password: String)
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorLoginProtocol: AnyObject {
    
    var presenter: InteractorToPresenterLoginProtocol? { get set }
    func loginUser(login: String, password: String)
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterLoginProtocol: AnyObject {
    func loginDidSucceed(token: String)
    func loginDidFail(error: String)
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterLoginProtocol: AnyObject {
    static func createModule() -> LoginViewController
    func navigateToMainScreen(from view: PresenterToViewLoginProtocol)
}
