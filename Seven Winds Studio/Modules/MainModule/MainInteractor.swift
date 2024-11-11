//
//  MainInteractor.swift
//  Seven Winds Studio
//
//  Created by Jam Mardonov on 07/11/24.
//  
//

import Foundation

final class MainInteractor: PresenterToInteractorMainProtocol {

    // MARK: Properties
    var presenter: InteractorToPresenterMainProtocol?
    
    func getLocations() {
        APIManager.shared.request(.locations) { (result: Result<[LocationsResponse], APIError>) in
            switch result {
            case .success(let locations):
                self.presenter?.fetchedLocationsSuccess(locations)
            case .failure(let error):
                self.presenter?.fetchedLocationsFailure(error.localizedDescription)
            }
        }
    }
}
