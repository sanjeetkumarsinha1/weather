//
//  SignupViewController.swift
//  Weather Forecast
//
//  Created by chetu on 20/03/23.
//

import UIKit

class SignupViewController: UIViewController {
    
    private let usernameTextField = UITextField()
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let repeatPasswordTextField = UITextField()
    
    private let consentStackView = ConsentStackView()
    private let agreementLabel = UILabel()
    private let createAccountButton = UIButton(type: .custom)
    private let agreementCheckbox = Checkbox()
    private let ageLabel = UILabel()
    private let informationLabel = UILabel()
    private let ageCheckbox = UIButton(type: .custom)
    private let policyCheckbox = UIButton(type: .custom)
    private let consentCheckbox = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // Configure text fields
        usernameTextField.placeholder = "Username"
        emailTextField.placeholder = "Enter email"
        passwordTextField.placeholder = "Password"
        repeatPasswordTextField.placeholder = "Repeat Password"
        passwordTextField.isSecureTextEntry = true
        repeatPasswordTextField.isSecureTextEntry = true
        
        // Configure information label
        informationLabel.text = "We will use information you provided for management and administration purposes, and for keeping you informed by mail, telephone, email and SMS of other products and services from us and our partners. You can proactively manage your preferences or opt-out of communications with us at any time using Privacy Centre. You have the right to access your data held by us or to request your data to be deleted. For full details please see the OpenWeather Privacy Policy."
        informationLabel.numberOfLines = 0
        
        // Configure checkboxes
        ageCheckbox.setImage(UIImage(systemName: "square"), for: .normal)
        ageCheckbox.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        ageCheckbox.setTitle("I am 16 years old and over", for: .normal)
        ageCheckbox.setTitleColor(.black, for: .normal)
        ageCheckbox.addTarget(self, action: #selector(ageCheckboxTapped), for: .touchUpInside)
        
        policyCheckbox.setImage(UIImage(systemName: "square"), for: .normal)
        policyCheckbox.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        policyCheckbox.setTitle("I agree with Privacy Policy, Terms and conditions of sale and Websites terms and conditions of use", for: .normal)
        policyCheckbox.setTitleColor(.black, for: .normal)
        policyCheckbox.addTarget(self, action: #selector(policyCheckboxTapped), for: .touchUpInside)
        
        consentCheckbox.setImage(UIImage(systemName: "square"), for: .normal)
        consentCheckbox.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        consentCheckbox.setTitle("I consent to receive communications from OpenWeather Group of Companies and their partners", for: .normal)
        consentCheckbox.setTitleColor(.black, for: .normal)
        consentCheckbox.addTarget(self, action: #selector(consentCheckboxTapped), for: .touchUpInside)
        
        // Add subviews and configure constraints
        view.addSubview(usernameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(repeatPasswordTextField)
        view.addSubview(informationLabel)
        view.addSubview(ageCheckbox)
        view.addSubview(policyCheckbox)
        view.addSubview(consentCheckbox)
        
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        repeatPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        informationLabel.translatesAutoresizingMaskIntoConstraints = false
        ageCheckbox.translatesAutoresizingMaskIntoConstraints = false
        policyCheckbox.translatesAutoresizingMaskIntoConstraints = false
        consentCheckbox.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            // Username text field
            usernameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50),
            // Email text field
            emailTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: padding),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            // Password text field
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: padding),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            // Repeat password text field
            repeatPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: padding),
            repeatPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            repeatPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            repeatPasswordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            // Age checkbox
            ageCheckbox.topAnchor.constraint(equalTo: repeatPasswordTextField.bottomAnchor, constant: padding),
            ageCheckbox.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            ageCheckbox.heightAnchor.constraint(equalToConstant: 50),
            ageCheckbox.widthAnchor.constraint(equalToConstant: 30),
            
            // Age label
            ageLabel.centerYAnchor.constraint(equalTo: ageCheckbox.centerYAnchor),
            ageLabel.leadingAnchor.constraint(equalTo: ageCheckbox.trailingAnchor, constant: 10),
            ageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            // Agreement checkbox
            agreementCheckbox.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: padding),
            agreementCheckbox.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            agreementCheckbox.heightAnchor.constraint(equalToConstant: 50),
            agreementCheckbox.widthAnchor.constraint(equalToConstant: 30),
            
            // Agreement label
            agreementLabel.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: padding),
            agreementLabel.leadingAnchor.constraint(equalTo: agreementCheckbox.trailingAnchor, constant: 10),
            agreementLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            // Consent stack view
            consentStackView.topAnchor.constraint(equalTo: agreementLabel.bottomAnchor, constant: padding),
            consentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            consentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            // Create account button
            createAccountButton.topAnchor.constraint(equalTo: consentStackView.bottomAnchor, constant: padding),
            createAccountButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            createAccountButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            createAccountButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding)
        ])
        
        // Set background color
        view.backgroundColor = .white
    }
    
    @objc func ageCheckboxTapped() {
        // Code to handle when the age checkbox is tapped
        if ageCheckbox.isSelected {
            // Age checkbox was deselected
            ageCheckbox.isSelected = false
            // Add code to handle when the age checkbox is deselected
        } else {
            // Age checkbox was selected
            ageCheckbox.isSelected = true
            // Add code to handle when the age checkbox is selected
        }
    }
    
    @objc func policyCheckboxTapped() {
        // Code to handle when the age checkbox is tapped
    }
    
    @objc func consentCheckboxTapped() {
        // Code to handle when the age checkbox is tapped
    }
}
    
    class Checkbox: UIButton {
        let checkedImage = UIImage(systemName: "checkmark.square.fill")!
        let uncheckedImage = UIImage(systemName: "square")!
        var isChecked: Bool = false {
            didSet {
                if isChecked {
                    setImage(checkedImage, for: .normal)
                } else {
                    setImage(uncheckedImage, for: .normal)
                }
            }
        }
        
        convenience init() {
            self.init(frame: .zero)
            addTarget(self, action:#selector(buttonClicked), for: .touchUpInside)
            isChecked = false
        }
        
        @objc func buttonClicked(sender: UIButton) {
            isChecked = !isChecked
        }
    }
    
    class ConsentStackView: UIStackView {
        
        let systemNewsCheckbox = Checkbox()
        let productNewsCheckbox = Checkbox()
        let corporateNewsCheckbox = Checkbox()
        
        // MARK: - Initialization
        
        convenience init() {
            self.init(frame: .zero)
            axis = .vertical
            spacing = 10
            
            let label = UILabel()
            label.text = "I consent to receive communications from OpenWeather Group of Companies and their partners:"
            label.numberOfLines = 0
            label.font = UIFont.systemFont(ofSize: 14)
            addArrangedSubview(label)
            
            let systemNewsStackView = makeCheckboxStackView(title: "System news (API usage alert, system update, temporary system shutdown, etc)", checkbox: systemNewsCheckbox)
            addArrangedSubview(systemNewsStackView)
            
            let productNewsStackView = makeCheckboxStackView(title: "Product news (change to price, new product features, etc)", checkbox: productNewsCheckbox)
            addArrangedSubview(productNewsStackView)
            
            let corporateNewsStackView = makeCheckboxStackView(title: "Corporate news (our life, the launch of a new service, etc)", checkbox: corporateNewsCheckbox)
            addArrangedSubview(corporateNewsStackView)
        }
        
        // MARK: - Private methods
        
        private func makeCheckboxStackView(title: String, checkbox: Checkbox) -> UIStackView {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.spacing = 10
            
            checkbox.translatesAutoresizingMaskIntoConstraints = false
            checkbox.widthAnchor.constraint(equalToConstant: 20).isActive = true
            checkbox.heightAnchor.constraint(equalToConstant: 20).isActive = true
            stackView.addArrangedSubview(checkbox)
            
            let label = UILabel()
            label.text = title
            label.numberOfLines = 0
            label.font = UIFont.systemFont(ofSize: 12)
            stackView.addArrangedSubview(label)
            
            return stackView
        }
    }

