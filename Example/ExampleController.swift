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

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
        let style = TextFieldStyle(background: .white,
                                   font: UIFont.systemFont(ofSize: 14, weight: .light),
                                   tintColor: .red,
                                   cornerRadius: 5.0,
                                   insets: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10),
                                   border: [.bottom])
        let textField = ETTextField(style: style)
        textField.placeholder = "Enter your name"

        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false

        textField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        textField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}

