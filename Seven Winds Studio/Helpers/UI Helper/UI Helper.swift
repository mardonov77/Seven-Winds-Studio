//
//  UI Helper.swift
//  Seven Winds Studio
//
//  Created by Jam Mardonov on 04/11/24.
//

import UIKit
import SnapKit

final class UIHelper {
    
    public static func generateLabel(text: String, font: CGFloat, weight: UIFont.Weight, color: UIColor) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: font, weight: weight)
        label.textColor = color
        label.numberOfLines = 1
        label.text = text
        return label
    }
    
    public static func generateTextField(placeholder: String, keyboardType: UIKeyboardType) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = #colorLiteral(red: 0.5176470588, green: 0.3882352941, blue: 0.2509803922, alpha: 1)
        textField.layer.borderWidth = 1.0
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 24.0
        textField.layer.masksToBounds = true
        textField.font = .systemFont(ofSize: 18.0)
        textField.keyboardType = keyboardType
        textField.leftViewMode = .always
        textField.autocorrectionType = .no
        textField.placeholder = placeholder
        textField.placeholderColor = #colorLiteral(red: 0.6862745098, green: 0.5803921569, blue: 0.4745098039, alpha: 1)
        
        let leftView = UIView()
        textField.leftView = leftView
        textField.addSubview(leftView)
        
        leftView.snp.makeConstraints {
            $0.width.equalTo(20.0)
            $0.height.equalTo(textField)
        }
        
        return textField
    }
    
    public static func generateButton(title: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.1764705882, blue: 0.1019607843, alpha: 1)
        button.layer.cornerRadius = 24.0
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
        button.setTitleColor(.white, for: .normal)
        return button
    }
    
    public static func generateStackView(
        axis: NSLayoutConstraint.Axis,
        alignment: UIStackView.Alignment,
        distribution: UIStackView.Distribution,
        spacing: CGFloat) -> UIStackView {
            
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = axis
            stackView.spacing = spacing
            stackView.distribution = distribution
            stackView.alignment = .center
            return stackView
        }
    
    public static func generateCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        return collectionView
    }
    
    public static func generateImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "photo")
        return imageView
    }
    
    public static func generateQuantityButton(color: UIColor, title: String, font: UIFont) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.setTitleColor(color, for: .normal)
        button.titleLabel?.font = font
        button.addPressAnimation()
        return button
    }
}
