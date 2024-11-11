//
//  UIButton+Extension.swift
//  Seven Winds Studio
//
//  Created by Jam Mardonov on 07/11/24.
//

import UIKit

extension UIButton {

    func addPressAnimation(scale: CGFloat = 0.95, duration: TimeInterval = 0.1) {
        addTarget(self, action: #selector(pressDown), for: .touchDown)
        addTarget(self, action: #selector(pressUp), for: [.touchUpInside, .touchUpOutside])
    }
    
    @objc private func pressDown() {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            self.alpha = 0.7
        })
    }
    
    @objc private func pressUp() {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform.identity
            self.alpha = 1.0
        })
    }
}
