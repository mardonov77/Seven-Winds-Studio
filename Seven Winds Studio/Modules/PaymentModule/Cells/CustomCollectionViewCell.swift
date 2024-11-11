//
//  CustomCell.swift
//  Seven Winds Studio
//
//  Created by Jam Mardonov on 08/11/24.
//

import UIKit

protocol CustomCollectionViewCellDelegate: AnyObject {
    func didUpdateQuantity(to quantity: Int, in cell: CustomCollectionViewCell)
}

final class CustomCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    static let identifier = "CustomCollectionViewCell"
    
    weak var delegate: CustomCollectionViewCellDelegate?
    
    private var quantity: Int = 0 {
        didSet {
            count.text = "\(quantity)"
            delegate?.didUpdateQuantity(to: quantity, in: self)
        }
    }
    
    //MARK: - UI Elements
    private let stackView: UIStackView = UIHelper.generateStackView(axis: .vertical, alignment: .leading, distribution: .fill, spacing: 8.0)
    private let title: UILabel = UIHelper.generateLabel(text: "BEDOEV COFFEE", font: 18.0, weight: .bold, color: #colorLiteral(red: 0.5176470588, green: 0.3882352941, blue: 0.2509803922, alpha: 1))
    private let subtitle: UILabel = UIHelper.generateLabel(text: "1км от вас", font: 14.0, weight: .regular, color: #colorLiteral(red: 0.6862745098, green: 0.5803921569, blue: 0.4745098039, alpha: 1))
    private let secondStackView: UIStackView = UIHelper.generateStackView(axis: .horizontal, alignment: .center, distribution: .fill, spacing: 14.0)
    private let count: UILabel = UIHelper.generateLabel(text: "1", font: 20.0, weight: .medium, color: #colorLiteral(red: 0.5176470588, green: 0.3882352941, blue: 0.2509803922, alpha: 1))
    private let minus: UIButton = UIHelper.generateQuantityButton(color: #colorLiteral(red: 0.5176470588, green: 0.3882352941, blue: 0.2509803922, alpha: 1.0), title: "-", font: UIFont.systemFont(ofSize: 20.0, weight: .bold))
    private let plus: UIButton = UIHelper.generateQuantityButton(color: #colorLiteral(red: 0.5176470588, green: 0.3882352941, blue: 0.2509803922, alpha: 1.0), title: "+", font: UIFont.systemFont(ofSize: 20.0, weight: .bold))
   
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
    
        title.text = nil
        subtitle.text = nil
        quantity = 0
    }
    
    //MARK: - Private methods
    
    private func setupSubviews() {
        contentView.backgroundColor = #colorLiteral(red: 0.9647316337, green: 0.8956287503, blue: 0.8231813908, alpha: 1)
        contentView.layer.cornerRadius = 10.0
        contentView.addSubviews(
            stackView,
            secondStackView
        )
        
        stackView.addArrangedSubviews(title, subtitle)
        secondStackView.addArrangedSubviews(minus, count, plus)
        setupShadow()
    }
    
    private func setupShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: .zero, height: 2.0)
        layer.shadowRadius = 4.0
        layer.masksToBounds = false
        layer.cornerRadius = 10.0
    }
    
    private func configConstraints() {
        
        title.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        subtitle.snp.makeConstraints {
            $0.left.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(10.0)
        }
        
        secondStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
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
    
    //MARK: - Public methods
    public func config(title: String, subtitle: String, count: String, subtitleFont: CGFloat, countHidden: Bool) {
        self.title.text = title
        self.subtitle.text = subtitle
        self.count.text = count
        self.quantity = count.toInt() ?? 0
        self.subtitle.font = UIFont.systemFont(ofSize: subtitleFont)
        self.subtitle.font = UIFont.systemFont(ofSize: subtitleFont)
        secondStackView.isHidden = countHidden
    }
}




