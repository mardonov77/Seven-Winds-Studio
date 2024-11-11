//
//  MapPresenter.swift
//  Seven Winds Studio
//
//  Created by Jam Mardonov on 08/11/24.
//  
//

final class MapPresenter: ViewToPresenterMapProtocol {

    weak var view: PresenterToViewMapProtocol?
    var interactor: PresenterToInteractorMapProtocol?
    var router: PresenterToRouterMapProtocol?

    var locations: [LocationsResponse] = []

    func viewDidLoad() {
        guard !locations.isEmpty else {
            view?.showError("No locations to display")
            return
        }
        view?.showLocations(locations)
    }
}

extension MapPresenter: InteractorToPresenterMapProtocol {
    
}
