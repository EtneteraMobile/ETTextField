//
//  ETCustomErrorTextField.swift
//  ETTextField-iOS
//
//  Created by Marek Štovíček on 10/07/2020.
//  Copyright © 2020 ETTextField. All rights reserved.
//

import UIKit

public final class ETCustomErrorTextField: ETTextField {

    // MARK: - Variables
    private let errorView: UIView

    // MARK: - Initializer

    /// Initializing text field with style and custom error view (`UIView`)
    ///
    /// - Parameters:
    ///   - style: TextFieldStyle
    ///   - errorView: UIView
    public init(style: TextFieldStyle = TextFieldStyle(), errorView: UIView) {
        self.errorView = errorView
        super.init(style: style)
        setupErrorView()
    }

    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Content

    /// Shows custom error view below the`textField`.
    ///
    /// - Note:
    ///   - The error message is automatically hidden if any change occurs on the `textField`.
    ///   - You can explicitly hide the error message by using `hideError()`.
    ///   - The error view is shown with alpha animation - from 0 to 1.
    ///
    /// - Warning: Custom error view is **out of bounds** of the `textField`.
    public func showError() {
        isErrorHidden = false
        layoutIfNeeded()
        // swiftlint:disable:next trailing_closure
        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseIn, animations: {
            if self.isEnabled || self.style.disabledTintColor == nil {
                self.border.updateColor(self.errorColor)
            }
            self.errorView.alpha = 1.0
            self.errorView.isHidden = false
            self.layoutIfNeeded()
        })
    }

    /// Hides custom error view
    ///
    /// - Note:
    ///   - The error view is hidden with alpha animation - from 1 to 0.
    override public func hideError() {
        isErrorHidden = true
        layoutIfNeeded()
        UIView.animate(withDuration: animationDuration,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
            self.border.updateColor(self.borderColor)
            self.errorView.alpha = 0.0
            self.layoutIfNeeded()
        }, completion: { _ in
            self.errorView.isHidden = true
        })
    }

    @available(*, unavailable)
    override public func showError(message: String) {

    }
}

private extension ETCustomErrorTextField {

    func setupErrorView() {
        errorView.alpha = 0.0
        addSubview(errorView)
        errorView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: bottomAnchor),
            errorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

        errorView.isHidden = true
    }
}
