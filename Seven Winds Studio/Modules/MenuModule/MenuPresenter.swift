//
//  MenuPresenter.swift
//  Seven Winds Studio
//
//  Created by Jam Mardonov on 09/11/24.
//  
//

import Foundation

final class MenuPresenter: ViewToPresenterMenuProtocol {
    
    // MARK: Properties
    weak var view: PresenterToViewMenuProtocol?
    internal var interactor: PresenterToInteractorMenuProtocol?
    internal var router: PresenterToRouterMenuProtocol?
    
    private var menuItems: [MenuResponse] = []
    private var locationId: Int

    init(locationId: Int) {
        self.locationId = locationId
    }

    func viewDidLoad() {
        interactor?.fetchMenu(locationId: locationId)
    }
    
    func goToPayment(with selectedItems: [SelectedItem]) {
        router?.navigateToPayment(from: view!, with: selectedItems)
    }
}

extension MenuPresenter: InteractorToPresenterMenuProtocol {
    func menuFetchedSuccess(menuItems: [MenuResponse]) {
        self.menuItems = menuItems
        view?.updateMenuItems(menuItems: menuItems)
    }
    
    func menuFetchFailed(error: String) {
        view?.onMenuFetchFailure(error: error)
    }
}
