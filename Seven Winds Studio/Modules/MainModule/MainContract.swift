//
//  MainContract.swift
//  Seven Winds Studio
//
//  Created by Jam Mardonov on 07/11/24.
//  
//

import Foundation

// MARK: View Output (Presenter -> View)
protocol PresenterToViewMainProtocol: AnyObject {
    func showLocations(_ locations: [LocationsResponse])
    func showError(_ message: String)
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterMainProtocol: AnyObject {
    
    var view: PresenterToViewMainProtocol? { get set }
    var interactor: PresenterToInteractorMainProtocol? { get set }
    var router: PresenterToRouterMainProtocol? { get set }
    
    func fetchLocations()
    func didTapOnLocation(with id: Int)
    func didTapShowOnMap()
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorMainProtocol: AnyObject {
    
    var presenter: InteractorToPresenterMainProtocol? { get set }
    func getLocations()
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterMainProtocol: AnyObject {
    func fetchedLocationsSuccess(_ locations: [LocationsResponse])
    func fetchedLocationsFailure(_ error: String)
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterMainProtocol: AnyObject {
    static func createModule() -> MainViewController
    func navigateToMenuModule(from view: PresenterToViewMainProtocol, with id: Int)
    func navigateToMapScreen(from view: PresenterToViewMainProtocol, with locations: [LocationsResponse])
}
