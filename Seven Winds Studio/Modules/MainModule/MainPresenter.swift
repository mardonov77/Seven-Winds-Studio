//
//  MainPresenter.swift
//  Seven Winds Studio
//
//  Created by Jam Mardonov on 07/11/24.
//  
//

import Foundation

final class MainPresenter: ViewToPresenterMainProtocol {

    weak var view: PresenterToViewMainProtocol?
    internal var interactor: PresenterToInteractorMainProtocol?
    internal var router: PresenterToRouterMainProtocol?

    private var locations: [LocationsResponse] = []

    func fetchLocations() {
        interactor?.getLocations()
    }
    
    func didTapOnLocation(with id: Int) {
        router?.navigateToMenuModule(from: view!, with: id)
    }

    func didTapShowOnMap() {
        guard !locations.isEmpty else { return }
        router?.navigateToMapScreen(from: view!, with: locations)
    }
}

extension MainPresenter: InteractorToPresenterMainProtocol {
    
    func fetchedLocationsSuccess(_ locations: [LocationsResponse]) {
        self.locations = locations
        view?.showLocations(locations)
    }
    
    func fetchedLocationsFailure(_ error: String) {
        view?.showError(error)
    }
}
