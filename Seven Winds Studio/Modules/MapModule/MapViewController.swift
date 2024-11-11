//
//  MapViewController.swift
//  Seven Winds Studio
//
//  Created by Jam Mardonov on 08/11/24.
//
//

import UIKit
import YandexMapsMobile

final class MapViewController: UIViewController {
    
    // MARK: - Properties
    internal var presenter: ViewToPresenterMapProtocol?
    
    
    // MARK: - UI Elements
    private let topView = TopView()
    private let mapView: YMKMapView = {
        let mapView = YMKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    // MARK: - Lifecycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        topView.config(title: "Карта", isHidden: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        subscribeToDelegates()
        showUserLocation()
        configConstraints()
        presenter?.viewDidLoad()
    }
    
    // MARK: - Private Methods
    private func setupSubviews() {
        view.backgroundColor = #colorLiteral(red: 0.9812716842, green: 0.9763050675, blue: 0.9763934016, alpha: 1)
        view.addSubviews(topView, mapView)
    }
    
    private func subscribeToDelegates() {
        topView.delegate = self
    }
    
    private func showUserLocation() {
        mapView.mapWindow.map.isRotateGesturesEnabled = false
        
        let userLocationLayer = YMKMapKit.sharedInstance().createUserLocationLayer(with: mapView.mapWindow)
        userLocationLayer.setVisibleWithOn(true)
        userLocationLayer.isHeadingEnabled = true
    }
    
    private func configConstraints() {
        topView.snp.makeConstraints {
            $0.top.equalTo(view.layoutMarginsGuide)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(48.0)
        }
        
        mapView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
    }
}

// MARK: - PresenterToViewMapProtocol
extension MapViewController: PresenterToViewMapProtocol {
    func showLocations(_ locations: [LocationsResponse]) {
        guard !locations.isEmpty else { return }
        
        for location in locations {
            guard let latitude = Double(location.point.latitude),
                  let longitude = Double(location.point.longitude) else { continue }

            let point = YMKPoint(latitude: latitude, longitude: longitude)
            let placemark = mapView.mapWindow.map.mapObjects.addPlacemark()
            placemark.geometry = point
            placemark.setIconWith(UIImage(named: "icon") ?? UIImage())
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [weak self] in
            if let firstLocation = locations.first,
               let firstLatitude = Double(firstLocation.point.latitude),
               let firstLongitude = Double(firstLocation.point.longitude) {
                let firstPoint = YMKPoint(latitude: firstLatitude, longitude: firstLongitude)
                let cameraPosition = YMKCameraPosition(target: firstPoint, zoom: 9.0, azimuth: .zero, tilt: .zero)
                let animation = YMKAnimation(type: .smooth, duration: 1.5)
                self?.mapView.mapWindow.map.move(with: cameraPosition, animation: animation, cameraCallback: nil)
            }
        })
    }

    func showError(_ message: String) {
        showToast(message: message)
    }
}

// MARK: - TopViewDelegate
extension MapViewController: TopViewDelegate {
    func dismissVC() {
        navigationController?.popViewController(animated: true)
    }
}
