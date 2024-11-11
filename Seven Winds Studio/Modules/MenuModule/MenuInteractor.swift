//
//  MenuInteractor.swift
//  Seven Winds Studio
//
//  Created by Jam Mardonov on 09/11/24.
//
//

import Foundation

final class MenuInteractor: PresenterToInteractorMenuProtocol {
    
    // MARK: Properties
    var presenter: InteractorToPresenterMenuProtocol?
    
    func fetchMenu(locationId: Int) {
        APIManager.shared.request(.menu(locationId: locationId)) { (result: Result<[MenuResponse], APIError>) in
            switch result {
            case .success(let menuItems):
                self.presenter?.menuFetchedSuccess(menuItems: menuItems)
            case .failure(let error):
                self.presenter?.menuFetchFailed(error: error.localizedDescription)
            }
        }
    }
}
