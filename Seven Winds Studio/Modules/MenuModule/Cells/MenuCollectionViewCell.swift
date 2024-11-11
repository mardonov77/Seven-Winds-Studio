//
//  MenuCollectionViewCell.swift
//  Seven Winds Studio
//
//  Created by Jam Mardonov on 09/11/24.
//

import UIKit
import Kingfisher

final class MenuCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties
    static let identifier = "MenuCollectionViewCell"
    
    private var quantity: Int = 0 {
        didSet {
            quantityLabel.text = "\(quantity)"
            onQuantityChange?(quantity)
        }
    }
    var onQuantityChange: ((Int) -> Void)?
    //MARK: - UI Elements
    private let stackView: UIStackView = UIHelper.generateStackView(axis: .vertical, alignment: .leading, distribution: .fill, spacing: 8.0)
    private let imageView: UIImageView = UIHelper.generateImageView()
    private let titleLabel: UILabel = UIHelper.generateLabel(text: "Экспрессо", font: 15.0, weight: .regular, color: #colorLiteral(red: 0.6862745098, green: 0.5803921569, blue: 0.4745098039, alpha: 1))
    private let priceLabel: UILabel = UIHelper.generateLabel(text: "200 руб", font: 14.0, weight: .medium, color: #colorLiteral(red: 0.5176470588, green: 0.3882352941, blue: 0.2509803922, alpha: 1))
    private let secondStackView: UIStackView = UIHelper.generateStackView(axis: .horizontal, alignment: .center, distribution: .fill, spacing: 10.0)
    private let quantityLabel: UILabel = UIHelper.generateLabel(text: "0", font: 20.0, weight: .regular, color: #colorLiteral(red: 0.5176470588, green: 0.3882352941, blue: 0.2509803922, alpha: 1))
    private let minus: UIButton = UIHelper.generateQuantityButton(color: #colorLiteral(red: 0.9731794, green: 0.9173260331, blue: 0.8534517288, alpha: 1.0), title: "-", font: UIFont.systemFont(ofSize: 20.0, weight: .semibold))
    private let plus: UIButton = UIHelper.generateQuantityButton(color: #colorLiteral(red: 0.9731794, green: 0.9173260331, blue: 0.8534517288, alpha: 1.0), title: "+", font: UIFont.systemFont(ofSize: 20.0, weight: .semibold))
    
    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        configConstraints()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        titleLabel.text = nil
        priceLabel.text = nil
        quantity = 0
    }
    
    //MARK: - Private methods
    
    private func setupSubviews() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10.0
        
        contentView.addSubviews(imageView, titleLabel, priceLabel, secondStackView)
        
        secondStackView.addArrangedSubviews(minus, quantityLabel, plus)
        setupShadow()
    }
    
    private func setupShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: .zero, height: 2.0)
        layer.shadowRadius = 4.0
        layer.masksToBounds = false
        layer.cornerRadius = 10.0
    }
    
    private func configConstraints() {
        
        imageView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(138.0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).inset(-10.0)
            $0.left.right.equalToSuperview().inset(10.0)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(-20.0)
            $0.left.equalTo(titleLabel)
        }
        
        secondStackView.snp.makeConstraints {
            $0.centerY.equalTo(priceLabel)
            $0.right.equalToSuperview().inset(10.0)
        }
    }
    
    private func setupActions() {
        plus.addTarget(self, action: #selector(incrementQuantity), for: .touchUpInside)
        minus.addTarget(self, action: #selector(decrementQuantity), for: .touchUpInside)
    }
    
    //MARK: - Actions
    @objc private func incrementQuantity() {
        self.quantity += 1
    }
    
    @objc private func decrementQuantity() {
        if self.quantity > 0 {
            self.quantity -= 1
        }
    }
    
    @objc private func quantityChanged(_ sender: UIStepper) {
        let newQuantity = Int(sender.value)
        onQuantityChange?(newQuantity)
    }
    
    //MARK: - Public methods
    public func config(with product: MenuResponse) {
        let url = URL(string: product.imageURL)
        imageView.kf.setImage(with: url)
        titleLabel.text = product.name
        priceLabel.text = "\(product.price) руб"
    }
}
