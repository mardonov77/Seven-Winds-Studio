//
//  MenuViewController.swift
//  Seven Winds Studio
//
//  Created by Jam Mardonov on 09/11/24.
//  
//

import UIKit

final class MenuViewController: UIViewController {
    
    // MARK: - Properties
    var presenter: ViewToPresenterMenuProtocol?
    
    var menuItems: [MenuResponse] = []
    var locationId: Int = 0
    
    var selectedItems: [Int: SelectedItem] = [:]
   
    // MARK: - UI Elements
    
    private let topView = TopView()
    private let stackView: UIStackView = UIHelper.generateStackView(axis: .vertical, alignment: .center, distribution: .fill, spacing: 10.0)
    private let collectionView: UICollectionView = UIHelper.generateCollectionView()
    private let button: UIButton = UIHelper.generateButton(title: "Перейти к оплате")
    
    // MARK: - Lifecycle Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        topView.config(title: "Меню", isHidden: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        subscribeToDelegates()
        setupActions()
        configConstraints()
        presenter?.viewDidLoad()
    }
    
    // MARK: - Private Methods
    
    private func setupSubviews() {
        addSwipeToRoot()
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
        collectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: MenuCollectionViewCell.identifier)
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
            self.presenter?.goToPayment(with: Array(self.selectedItems.values))
        }
    }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource & UICollectionViewDelegateFlowLayout
extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath) as! MenuCollectionViewCell
        cell.prepareForReuse()
        let product = menuItems[indexPath.row]
        cell.config(with: product)
        
        cell.onQuantityChange = { [weak self] newQuantity in
            guard let self = self else { return }
            
            if newQuantity > 0 {
                self.selectedItems[product.id] = SelectedItem(name: product.name, price: product.price, quantity: newQuantity)
            } else {
                self.selectedItems.removeValue(forKey: product.id)
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsInRow: CGFloat = 2.0
        let sectionInsets: CGFloat = 16.0
        let padding: CGFloat = 16.0
        let totalWidth = collectionView.bounds.width - sectionInsets * 2.0 - padding * (itemsInRow - 1.0)
        let width = totalWidth / itemsInRow
        
        return CGSize(width: width, height: width + 30.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20.0, left: 16.0, bottom: 16.0, right: 16.0)
    }
}

// MARK: - PresenterToViewMenuProtocol
extension MenuViewController: PresenterToViewMenuProtocol{
  
    func updateMenuItems(menuItems: [MenuResponse]) {
        self.menuItems = menuItems
        collectionView.reloadData()
    }
    
    func onMenuFetchFailure(error: String) {
        showToast(message: error)
    }
}

// MARK: - TopViewDelegate
extension MenuViewController: TopViewDelegate {
    func dismissVC() {
        navigationController?.popViewController(animated: true)
    }
}
