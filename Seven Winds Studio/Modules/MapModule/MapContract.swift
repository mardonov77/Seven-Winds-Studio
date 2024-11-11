//
//  MapContract.swift
//  Seven Winds Studio
//
//  Created by Jam Mardonov on 08/11/24.
//  
//

import YandexMapsMobile

// MARK: View Output (Presenter -> View)
protocol PresenterToViewMapProtocol: AnyObject {
    func showLocations(_ locations: [LocationsResponse])
    func showError(_ message: String)
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterMapProtocol: AnyObject {
    var view: PresenterToViewMapProtocol? { get set }
    var interactor: PresenterToInteractorMapProtocol? { get set }
    var router: PresenterToRouterMapProtocol? { get set }
    var locations: [LocationsResponse] { get set }

    func viewDidLoad()
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorMapProtocol: AnyObject {
    
    var presenter: InteractorToPresenterMapProtocol? { get set }
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterMapProtocol: AnyObject {
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterMapProtocol: AnyObject {
    static func createModule(with locations: [LocationsResponse]) -> MapViewController
}
