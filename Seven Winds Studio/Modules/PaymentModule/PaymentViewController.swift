//
//  PaymentViewController.swift
//  Seven Winds Studio
//
//  Created by Jam Mardonov on 10/11/24.
//  
//

import UIKit

final class PaymentViewController: UIViewController {
    
    // MARK: - Properties
    var presenter: ViewToPresenterPaymentProtocol?
    var items: [SelectedItem] = []
    
    // MARK: - UI Elements
    
    private let topView = TopView()
    private let stackView: UIStackView = UIHelper.generateStackView(axis: .vertical, alignment: .center, distribution: .fill, spacing: 10.0)
    private let collectionView: UICollectionView = UIHelper.generateCollectionView()
    private let button: UIButton = UIHelper.generateButton(title: "Оплатить")
    
    // MARK: - Lifecycle Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        topView.config(title: "Ваш заказ", isHidden: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        subscribeToDelegates()
        setupActions()
        configConstraints()
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
        
        stackView.backgroundColor = .white
    }
    
    @objc private func didTapButton() {
        showToast(message: "Время ожидания заказа\n15 минут!\nСпасибо, что выбрали нас!")
        items.removeAll()
        UIView.transition(with: collectionView, duration: 0.35, options: .transitionCrossDissolve, animations: {
            self.collectionView.reloadData()
        }, completion: nil)
    }
}

//MARK: - UICollectionViewDelegate & UICollectionViewDataSource & UICollectionViewDelegateFlowLayout
extension PaymentViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        cell.delegate = self
            let selectedItem = items[indexPath.row]
        cell.config(title: selectedItem.name, subtitle: String("\(selectedItem.price) руб"), count: String(selectedItem.quantity), subtitleFont: 16.0, countHidden: false)
            return cell
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

//MARK: - CustomCollectionViewCellDelegate
extension PaymentViewController: CustomCollectionViewCellDelegate {
    
    func didUpdateQuantity(to quantity: Int, in cell: CustomCollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        
        if quantity == 0 {
            items.remove(at: indexPath.row)
            
            collectionView.performBatchUpdates({
                collectionView.deleteItems(at: [indexPath])
            }, completion: nil)
        }
    }
}

//MARK: - PresenterToViewPaymentProtocol
extension PaymentViewController: PresenterToViewPaymentProtocol{
    func showError(_ message: String) {
        showToast(message: message)
    }
}

//MARK: - TopViewDelegate
extension PaymentViewController: TopViewDelegate {
    func dismissVC() {
        navigationController?.popViewController(animated: true)
    }
}
