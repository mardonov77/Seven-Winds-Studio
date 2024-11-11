//
//  TopView.swift
//  Seven Winds Studio
//
//  Created by Jam Mardonov on 07/11/24.
//

import UIKit

protocol TopViewDelegate: AnyObject {
    func dismissVC()
}

final class TopView: UIView {
    
    //MARK: - Properties
    weak var delegate: TopViewDelegate?
    
    //MARK: - UI Elements
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
        label.numberOfLines = 1
        label.textColor = #colorLiteral(red: 0.5176470588, green: 0.3882352941, blue: 0.2509803922, alpha: 1)
        return label
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = #colorLiteral(red: 0.5176470588, green: 0.3882352941, blue: 0.2509803922, alpha: 1)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        return button
    }()
    
    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupActions()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public methods
    public func config(title: String, isHidden: Bool) {
        titleLabel.text = title
        backButton.isHidden = isHidden
    }
    //MARK: - Private methods
    
    private func setupSubviews() {
        backgroundColor = #colorLiteral(red: 0.9812716842, green: 0.9763050675, blue: 0.9763934016, alpha: 1)
        
        addSubview(titleLabel)
        addSubview(backButton)
    }
    
    private func setupActions() {
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
    }
    
    private func configConstraints() {
        backButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(15.0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    @objc private func didTapBackButton(){
        backButton.showAnimation {
            self.delegate?.dismissVC()
        }
    }
}
