//
//  ETTextField.swift
//  ETTextField
//
//  Created by Miroslav Beles on 10/08/2019.
//  Copyright © 2019 ETTextField. All rights reserved.
//

import UIKit

open class ETTextField: UITextField {

    // MARK: - Variables
    // MARK: public

    let style: TextFieldStyle
    var insets: UIEdgeInsets = .zero

    // MARK: private

    private var borders: [UIView] = []

    public init(style: TextFieldStyle) {
        self.style = style
        super.init(frame: .zero)

        clipsToBounds = true
        setupStyle()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupStyle() {
        backgroundColor = style.background
        font = style.font
        layer.cornerRadius = style.cornerRadius
        insets = style.insets
        tintColor = style.tintColor
        style.border.forEach {
            addLine(to: $0)
        }
    }

    private func addLine(to side: Border) {
        let border = UIView()
        border.backgroundColor = tintColor
        addSubview(border)
        border.translatesAutoresizingMaskIntoConstraints = false

        let thickness: CGFloat = 2.0

        switch side {
        case .top:
            border.topAnchor.constraint(equalTo: topAnchor).isActive = true
            border.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            border.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            border.heightAnchor.constraint(equalToConstant: thickness).isActive = true
        case .right:
            border.topAnchor.constraint(equalTo: topAnchor).isActive = true
            border.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            border.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            border.widthAnchor.constraint(equalToConstant: thickness).isActive = true
        case .bottom:
            border.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            border.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            border.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            border.heightAnchor.constraint(equalToConstant: thickness).isActive = true
            break
        case .left:
            border.topAnchor.constraint(equalTo: topAnchor).isActive = true
            border.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            border.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            border.widthAnchor.constraint(equalToConstant: thickness).isActive = true
        }

        borders.append(border)
    }

    // Insets
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
}
