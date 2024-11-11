//
//  UIViewController+Extension.swift
//  Seven Winds Studio
//
//  Created by Jam Mardonov on 04/11/24.
//

import UIKit

extension UIViewController {
    
    func addSwipeToRoot() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture))
        swipeGesture.direction = .right
        view.addGestureRecognizer(swipeGesture)
    }
    
    @objc private func handleSwipeGesture() {
        navigationController?.popViewController(animated: true)
    }
}

extension UIViewController: UIGestureRecognizerDelegate {
    func addDismissKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIViewController {
    
    func showToast(message: String, duration: TimeInterval = 2.0) {
        
        let toastContainer = UIView(frame: CGRect())
        toastContainer.translatesAutoresizingMaskIntoConstraints = false
        toastContainer.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        toastContainer.alpha = .zero
        toastContainer.layer.cornerRadius = 10.0
        toastContainer.clipsToBounds = true
        
        let toastLabel = UILabel(frame: CGRect())
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont.systemFont(ofSize: 14.0)
        toastLabel.text = message
        toastLabel.clipsToBounds = true
        toastLabel.numberOfLines = 0
        
        toastContainer.addSubview(toastLabel)
        self.view.addSubview(toastContainer)
        
        toastLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10.0)
        }
        
        toastContainer.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20.0)
            $0.bottom.equalToSuperview().inset(40.0)
        }
        
        UIView.animate(withDuration: 0.5, delay: .zero, options: .curveEaseIn, animations: {
            toastContainer.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, delay: duration, options: .curveEaseOut, animations: {
                toastContainer.alpha = .zero
            }, completion: { _ in
                toastContainer.removeFromSuperview()
            })
        })
    }
}
