//
//  ExampleController.swift
//  Example
//
//  Created by Beles on 10/08/2019.
//  Copyright © 2019 ETTextField. All rights reserved.
//

import UIKit
import ETTextField

class ExampleController: UIViewController {

    private let textField1 = ETTextField()
    private let textField2 = ETTextField()
    private let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTextFieldOne()
        setupTextFieldTwo()
        setupShowErrorButton()
        setupObservers()

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapOutside))
        view.addGestureRecognizer(tapRecognizer)
    }

    private func setupTextFieldOne() {
        let style1 = TextFieldStyle(background: UIColor(white: 245.0/255.0, alpha: 1),
                                    font: UIFont.systemFont(ofSize: 14, weight: .light),
                                    tintColor: .blue,
                                    cornerRadius: 5.0,
                                    insets: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10),
                                    border: [.bottom],
                                    borderColor: .blue)
        textField1.update(with: style1)
        textField1.placeholder = "Enter your first name"
        textField1.title = "YOUR FIRST NAME:"
        textField1.titleOffset = -3.0

        view.addSubview(textField1)
        textField1.translatesAutoresizingMaskIntoConstraints = false

        textField1.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textField1.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        textField1.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        textField1.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    private func setupTextFieldTwo() {
        let style2 = TextFieldStyle(background: .clear,
                                    font: UIFont.systemFont(ofSize: 14, weight: .light),
                                    tintColor: .blue,
                                    cornerRadius: 0.0,
                                    insets: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10),
                                    border: [.top, .right, .bottom, .left],
                                    borderColor: .lightGray)
        textField2.update(with: style2)
        textField2.placeholder = "Enter your last name"
        textField2.title = "YOUR LAST NAME:"
        textField2.titleOffset = -3.0

        view.addSubview(textField2)
        textField2.translatesAutoresizingMaskIntoConstraints = false

        textField2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textField2.topAnchor.constraint(equalTo: textField1.bottomAnchor, constant: 35).isActive = true
        textField2.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        textField2.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    private func setupShowErrorButton() {
        button.setTitle("Show errors", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.topAnchor.constraint(equalTo: textField2.bottomAnchor, constant: 35).isActive = true
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

        textField1.onDidBeginEditing.observe(owner: label) {
            label.text = "TextField 1: Did begin editing"
        }

        textField1.onDidEndEditing.observe(owner: label) {
            label.text = "TextField 1: Did end editing"
        }

        textField1.onDidChangeText.observe(owner: label) { text in
            label.text = "TextField 1: \(text ?? "<empty>")"
        }

        textField1.onReturnKeyPressed.observe(owner: self) {
            label.text = "TextField 1: Did press return key"
            self.textField2.becomeFirstResponder()
        }

        textField2.onDidBeginEditing.observe(owner: label) {
            label.text = "TextField 2: Did begin editing"
        }

        textField2.onDidEndEditing.observe(owner: label) {
            label.text = "TextField 2: Did end editing"
        }

        textField2.onDidChangeText.observe(owner: label) { text in
            label.text = "TextField 2: \(text ?? "<empty>")"
        }

        textField2.onReturnKeyPressed.observe(owner: label) {
            label.text = "TextField 2: Did press return key"
        }
    }

    @objc private func showError() {
        textField1.showError(message: "Error example")
        textField2.showError(message: "Error example")
    }

    @objc private func didTapOutside() {
        view.endEditing(true)
    }
}

