//
//  ExampleController.swift
//  Example
//
//  Created by Beles on 10/08/2019.
//  Copyright © 2019 ETTextField. All rights reserved.
//

import ETTextField
import UIKit

class ExampleController: UIViewController {

    private let firstNameTF = ETTextField()
    private let secondNameTF = ETTextField()
    private lazy var customErrorTF = ETCustomErrorTextField(errorView: self.makeCustomErrorView())
    private let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupFirstNameTF()
        setupSecondNameTF()
        setupCustomErrorTF()
        setupShowErrorButton()
        setupObservers()

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapOutside))
        view.addGestureRecognizer(tapRecognizer)
    }

    private func setupFirstNameTF() {
        let style = TextFieldStyle(background: #colorLiteral(white: 245.0 / 255.0, alpha: 1),
                                   font: UIFont.systemFont(ofSize: 14, weight: .light),
                                   tintColor: .blue,
                                   cornerRadius: 5.0,
                                   insets: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10),
                                   border: [.bottom],
                                   borderColor: .blue)
        firstNameTF.update(with: style)
        firstNameTF.placeholder = "Enter your first name"
        firstNameTF.title = "YOUR FIRST NAME:"
        firstNameTF.titleOffset = -3.0

        view.addSubview(firstNameTF)
        firstNameTF.translatesAutoresizingMaskIntoConstraints = false

        firstNameTF.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        firstNameTF.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        firstNameTF.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        firstNameTF.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    private func setupSecondNameTF() {
        let style = TextFieldStyle(background: .clear,
                                   font: UIFont.systemFont(ofSize: 14, weight: .light),
                                   tintColor: .blue,
                                   cornerRadius: 0.0,
                                   insets: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10),
                                   border: [.top, .right, .bottom, .left],
                                   borderColor: .lightGray)
        secondNameTF.update(with: style)
        secondNameTF.placeholder = "Enter your last name"
        secondNameTF.title = "YOUR LAST NAME:"
        secondNameTF.titleOffset = -3.0

        view.addSubview(secondNameTF)
        secondNameTF.translatesAutoresizingMaskIntoConstraints = false

        secondNameTF.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        secondNameTF.topAnchor.constraint(equalTo: firstNameTF.bottomAnchor, constant: 35).isActive = true
        secondNameTF.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        secondNameTF.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    private func setupCustomErrorTF() {
        let style = TextFieldStyle(background: .clear,
                                   font: UIFont.systemFont(ofSize: 14, weight: .light),
                                   tintColor: .blue,
                                   cornerRadius: 0.0,
                                   insets: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10),
                                   borderColor: .lightGray)

        customErrorTF.update(with: style)
        customErrorTF.placeholder = "Enter your e-mail"
        customErrorTF.title = "YOUR E-MAIL"

        view.addSubview(customErrorTF)
        customErrorTF.translatesAutoresizingMaskIntoConstraints = false

        customErrorTF.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        customErrorTF.topAnchor.constraint(equalTo: secondNameTF.bottomAnchor, constant: 35).isActive = true
        customErrorTF.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
    }

    private func setupShowErrorButton() {
        button.setTitle("Show errors", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.topAnchor.constraint(equalTo: customErrorTF.bottomAnchor, constant: 35).isActive = true
        button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.addTarget(self, action: #selector(showError), for: .touchUpInside)
    }

    private func setupObservers() {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 35).isActive = true
        label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true

        firstNameTF.onDidBeginEditing.observe(owner: label) {
            label.text = "firstNameTF: Did begin editing"
        }

        firstNameTF.onDidEndEditing.observe(owner: label) {
            label.text = "firstNameTF: Did end editing"
        }

        firstNameTF.onDidChangeText.observe(owner: label) { text in
            label.text = "firstNameTF: \(text ?? "<empty>")"
        }

        firstNameTF.onReturnKeyPressed.observe(owner: self) {
            label.text = "firstNameTF: Did press return key"
            self.secondNameTF.becomeFirstResponder()
        }

        secondNameTF.onDidBeginEditing.observe(owner: label) {
            label.text = "secondNameTF: Did begin editing"
        }

        secondNameTF.onDidEndEditing.observe(owner: label) {
            label.text = "secondNameTF: Did end editing"
        }

        secondNameTF.onDidChangeText.observe(owner: label) { text in
            label.text = "secondNameTF: \(text ?? "<empty>")"
        }

        secondNameTF.onReturnKeyPressed.observe(owner: label) {
            label.text = "secondNameTF: Did press return key"
        }

        customErrorTF.onDidBeginEditing.observe(owner: label) {
            label.text = "customErrorTF: Did begin editing"
        }

        customErrorTF.onDidEndEditing.observe(owner: label) {
            label.text = "customErrorTF: Did end editing"
        }

        customErrorTF.onDidChangeText.observe(owner: label) { text in
            label.text = "customErrorTF: \(text ?? "<empty>")"
        }

        customErrorTF.onReturnKeyPressed.observe(owner: label) {
            label.text = "customErrorTF: Did press return key"
        }
    }

    private func makeCustomErrorView() -> UIView {
        let customErrorView = UIView()
        customErrorView.backgroundColor = .red

        let errorLabel = UILabel()
        errorLabel.numberOfLines = 0
        errorLabel.lineBreakMode = .byWordWrapping
        errorLabel.text = "Wrong e-mail format"
        errorLabel.textColor = .white
        errorLabel.font = UIFont.systemFont(ofSize: 12)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false

        customErrorView.addSubview(errorLabel)

        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: customErrorView.topAnchor, constant: 5),
            errorLabel.leadingAnchor.constraint(equalTo: customErrorView.leadingAnchor, constant: 5),
            errorLabel.trailingAnchor.constraint(equalTo: customErrorView.trailingAnchor, constant: -5),
            errorLabel.bottomAnchor.constraint(equalTo: customErrorView.bottomAnchor, constant: -5)
        ])
        return customErrorView
    }

    @objc
    private func showError() {
        firstNameTF.showError(message: "Error example")
        secondNameTF.showError(message: "Error example")
        customErrorTF.showError()
    }

    @objc
    private func didTapOutside() {
        view.endEditing(true)
    }
}
