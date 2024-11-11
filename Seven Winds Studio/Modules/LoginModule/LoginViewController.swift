//
//  LoginViewController.swift
//  Seven Winds Studio
//
//  Created by Jam Mardonov on 02/11/24.
//  
//

import UIKit

final class LoginViewController: UIViewController {
    
    // MARK: - Properties
    internal var presenter: ViewToPresenterLoginProtocol?
    
    // MARK: - UI Elements
    
    private let topView = TopView()
    private let loginLabel: UILabel = UIHelper.generateLabel(text: "Ваш e-mail", font: 15.0, weight: .regular, color: #colorLiteral(red: 0.5176470588, green: 0.3882352941, blue: 0.2509803922, alpha: 1))
    private let loginTextFeild: UITextField = UIHelper.generateTextField(placeholder: "example@example.ru", keyboardType: .default)
    private let passwordLabel: UILabel = UIHelper.generateLabel(text: "Пароль", font: 15.0, weight: .regular, color: #colorLiteral(red: 0.5176470588, green: 0.3882352941, blue: 0.2509803922, alpha: 1))
    private let passwordTextField: UITextField = UIHelper.generateTextField(placeholder: "Введите пароль", keyboardType: .default)
    private let button: UIButton = UIHelper.generateButton(title: "Войти")
    private let verticalStackView: UIStackView = UIHelper.generateStackView(axis: .vertical, alignment: .center, distribution: .fill, spacing: 40.0)
    
    // MARK: - Lifecycle Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        topView.config(title: "Вход", isHidden: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupActions()
        subscribeToDelegates()
        configConstraints()
    }
    
    // MARK: - Private Methods
    
    private func setupSubviews() {
        addDismissKeyboardGesture()
        
        view.backgroundColor = #colorLiteral(red: 0.9812716842, green: 0.9763050675, blue: 0.9763934016, alpha: 1)
        view.addSubviews(topView, verticalStackView, loginLabel, passwordLabel)
        
        verticalStackView.addArrangedSubviews(
            loginTextFeild,
            passwordTextField,
            button
        )
        
        loginTextFeild.showAnimation {
            self.loginTextFeild.text = HelperConstantsManager.shared.userEmail
        }
    }
    
    private func setupActions() {
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    private func subscribeToDelegates() {
        loginTextFeild.delegate = self
        passwordTextField.delegate = self
    }
    
    private func configConstraints() {
        topView.snp.makeConstraints {
            $0.top.equalTo(view.layoutMarginsGuide)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(40.0)
        }
        
        let textFields = [loginTextFeild, passwordTextField]
        
        for textField in textFields {
            textField.snp.makeConstraints {
                $0.height.equalTo(48.0)
                $0.left.right.equalToSuperview()
            }
        }
        
        button.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(48.0)
        }
        
        verticalStackView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.left.right.equalToSuperview().inset(20.0)
        }
        
        verticalStackView.setCustomSpacing(22.0, after: passwordTextField)
        
        loginLabel.snp.makeConstraints {
            $0.left.equalTo(verticalStackView)
            $0.bottom.equalTo(verticalStackView.snp.top).inset(-8.0)
        }
        
        passwordLabel.snp.makeConstraints {
            $0.left.equalTo(verticalStackView)
            $0.bottom.equalTo(passwordTextField.snp.top).inset(-8.0)
        }
    }
    
    @objc private func didTapButton() {
        guard let email = loginTextFeild.text?.trimmingCharacters(in: .whitespacesAndNewlines), email.isValidEmail() else {
            showToast(message: "Неправильный e-mail")
            return
        }
        
        let password = passwordTextField.text ?? ""
        button.showAnimation {
            self.presenter?.didTapLogin(login: email, password: password)
        }
    }
}

//MARK: - PresenterToViewLoginProtocol
extension LoginViewController: PresenterToViewLoginProtocol {
    func showError(_ message: String) {
        showToast(message: message)
    }
}

//MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTextFeild {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            didTapButton()
        }
        return true
    }
}
