//
//  MenuContract.swift
//  Seven Winds Studio
//
//  Created by Jam Mardonov on 09/11/24.
//  
//

import Foundation

// MARK: View Output (Presenter -> View)
protocol PresenterToViewMenuProtocol: AnyObject {
    func updateMenuItems(menuItems: [MenuResponse])
    func onMenuFetchFailure(error: String)
}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterMenuProtocol: AnyObject {
    var view: PresenterToViewMenuProtocol? { get set }
    var interactor: PresenterToInteractorMenuProtocol? { get set }
    var router: PresenterToRouterMenuProtocol? { get set }
    func viewDidLoad()
    func goToPayment(with selectedItems: [SelectedItem])
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorMenuProtocol: AnyObject {
    var presenter: InteractorToPresenterMenuProtocol? { get set }
    func fetchMenu(locationId: Int)
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterMenuProtocol: AnyObject {
    func menuFetchedSuccess(menuItems: [MenuResponse])
    func menuFetchFailed(error: String)
}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterMenuProtocol: AnyObject {
    static func createModule(with locationId: Int) -> MenuViewController
    func navigateToPayment(from view: PresenterToViewMenuProtocol, with selectedItems: [SelectedItem])
}
