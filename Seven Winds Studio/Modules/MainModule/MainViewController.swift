//
//  MainViewController.swift
//  Seven Winds Studio
//
//  Created by Jam Mardonov on 07/11/24.
//  
//

import UIKit
import CoreLocation

final class MainViewController: UIViewController {
    
    // MARK: - Properties
    internal var presenter: ViewToPresenterMainProtocol?
    private var locations: [LocationsResponse] = []
    
    // MARK: - UI Elements
    
    private let topView = TopView()
    private let stackView: UIStackView = UIHelper.generateStackView(axis: .vertical, alignment: .center, distribution: .fill, spacing: 10.0)
    private let collectionView: UICollectionView = UIHelper.generateCollectionView()
    private let button: UIButton = UIHelper.generateButton(title: "На карте")
    
    // MARK: - Lifecycle Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        topView.config(title: "Ближайшие кофейни", isHidden: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        subscribeToDelegates()
        setupActions()
        configConstraints()
        NotificationCenter.default.addObserver(self, selector: #selector(locationDidUpdate), name: .locationUpdated, object: nil)
        presenter?.fetchLocations()
    }
    
    // MARK: - Private Methods
    
    private func setupSubviews() {
        view.backgroundColor = #colorLiteral(red: 0.9812716842, green: 0.9763050675, blue: 0.9763934016, alpha: 1)
        
        view.addSubviews(
            topView,
            stackView
        )
        
        stackView.addArrangedSubviews(
            collectionView,
            button
        )
    }
    
    private func subscribeToDelegates() {
        topView.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
    }
    
    private func setupActions() {
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    private func configConstraints() {
        
        topView.snp.makeConstraints {
            $0.top.equalTo(view.layoutMarginsGuide)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(40.0)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().inset(20.0)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
        
        button.snp.makeConstraints {
            $0.height.equalTo(48.0)
            $0.left.right.equalToSuperview().inset(20.0)
        }
    }
    
    @objc private func didTapButton() {
        button.showAnimation {
            self.presenter?.didTapShowOnMap()
        }
    }
    
    @objc private func locationDidUpdate() {
        collectionView.reloadData()
    }
}

//MARK: - UICollectionViewDelegate & UICollectionViewDataSource & UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locations.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        cell.prepareForReuse()
        let locationResponse = locations[indexPath.row]
        
        let latitude = Double(locationResponse.point.latitude) ?? .zero
        let longitude = Double(locationResponse.point.longitude) ?? .zero
        let targetLocation = CLLocation(latitude: latitude, longitude: longitude)
        
        if let distanceInMeters = LocationManager.shared.getDistance(to: targetLocation) {
            let distanceInKilometers = distanceInMeters / 1000.0
            let distanceString = String(format: "%.1f км от вас", distanceInKilometers)
            cell.config(title: locationResponse.name, subtitle: distanceString, count: "", subtitleFont: 14.0, countHidden: true)
        } else {
            cell.config(title: locationResponse.name, subtitle: "Местоположение не определено", count: "", subtitleFont: 14.0, countHidden: true)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.showAnimation {
            let locationResponse = self.locations[indexPath.row]
            let locationId = locationResponse.id
            
            self.presenter?.didTapOnLocation(with: locationId)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 20.0
        let height: CGFloat = 70.0
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20.0, left: .zero, bottom: .zero, right: .zero)
    }
}

//MARK: - PresenterToViewMainProtocol
extension MainViewController: PresenterToViewMainProtocol {
    func showLocations(_ locations: [LocationsResponse]) {
        self.locations = locations
        collectionView.reloadData()
    }
    
    func showError(_ message: String) {
        showToast(message: message)
    }
}

//MARK: - TopViewDelegate
extension MainViewController: TopViewDelegate {
    func dismissVC() {
        APIManager.shared.handleTokenExpired()
    }
}
