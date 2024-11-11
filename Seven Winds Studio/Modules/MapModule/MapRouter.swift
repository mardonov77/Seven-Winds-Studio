//
//  MapRouter.swift
//  Seven Winds Studio
//
//  Created by Jam Mardonov on 08/11/24.
//  
//

import Foundation
import UIKit

final class MapRouter: PresenterToRouterMapProtocol {
    
    // MARK: Static methods
    static func createModule(with locations: [LocationsResponse]) -> MapViewController {
        let viewController = MapViewController()
        
        let presenter: ViewToPresenterMapProtocol & InteractorToPresenterMapProtocol = MapPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = MapRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = MapInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        presenter.locations = locations
        
        return viewController
    }
}
