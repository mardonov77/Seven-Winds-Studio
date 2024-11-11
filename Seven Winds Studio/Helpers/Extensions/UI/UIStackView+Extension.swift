//
//  UIStackView+Extension.swift
//  Seven Winds Studio
//
//  Created by Jam Mardonov on 04/11/24.
//

import UIKit

// MARK: - Subviews

extension UIStackView {
    
    func addArrangedSubviews(_ views: UIView...) {
        for view in views { addArrangedSubview(view) }
    }
}
