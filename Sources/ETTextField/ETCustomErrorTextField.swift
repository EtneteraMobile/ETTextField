//
//  ETCustomErrorTextField.swift
//  ETTextField-iOS
//
//  Created by Marek Štovíček on 10/07/2020.
//  Copyright © 2020 ETTextField. All rights reserved.
//

import UIKit

open class ETCustomErrorTextField: ETTextField {

    // MARK: - Variables
    // MARK: Views
    private let errorView: UIView
    private var errorIconView: UIImageView?

    // MARK: Custom content
    private var errorIcon: UIImage?
    private var shouldShowErrorViewOnFocusOnly: Bool = false

    // MARK: - Initializer

    /// Initializing text field with style and custom error view (`UIView`)
    ///
    /// - Parameters:
    ///   - style: Style of the `ETTextField`
    ///   - errorView: Custom `UIView` used as a errorView under the `ETTextField`
    ///   - errorIcon: Optiona `UIImage` showed at the right side of `ETTextField` in case of error.
    public init(style: TextFieldStyle = TextFieldStyle(), errorView: UIView, errorIcon: UIImage? = nil) {
        self.errorView = errorView
        self.errorIcon = errorIcon

        super.init(style: style)

        setupErrorView()
        setupErrorIconView()
    }

    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Content

    /// Shows custom error view below the`textField`.
    ///
    /// - Parameter onFocusOnly: The flag that indicates that the custom error view should be showed
    /// only when textfield is the first responder. For a `true` value there will be animation that shows
    /// or hides custom error view while becoming/stoping being the first responder. Otherwise the custom error view is always visible
    /// in error state. Default value is `false`.
    ///
    /// - Note:
    ///   - The error message is automatically hidden if any change occurs on the `textField`.
    ///   - You can explicitly hide the error message by using `hideError()`.
    ///   - The error view is shown with alpha animation - from 0 to 1.
    ///   - The optional `errorIcon` provided in intialization is showed on the right side when the errorView is not visible (out of the textfile's editing mode).
    ///
    /// - Warning: Custom error view is **out of bounds** of the `textField`.
    public func showError(onFocusOnly: Bool = false) {
        isErrorHidden = false
        shouldShowErrorViewOnFocusOnly = onFocusOnly

        self.errorView.alpha = 0.0
        self.errorView.isHidden = false
        self.errorIconView?.alpha = 0.0
        self.errorIconView?.isHidden = false

        layoutIfNeeded()

        let animation = {
            // Border
            if self.isEnabled || self.style.disabledTintColor == nil {
                self.border.updateColor(self.style.errorColor)
            }

            // Error views and icons
            if self.shouldShowErrorViewOnFocusOnly == true && self.isFirstResponder == false {
                self.errorIconView?.alpha = 1.0
            } else {
                self.errorView.alpha = 1.0
            }

            self.layoutIfNeeded()
        }

        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseIn, animations: animation)
    }

    /// Hides custom error view and `errorIcon`.
    ///
    /// - Note:
    ///   - The error view is hidden with alpha animation - from 1 to 0.
    ///   -
    override public func hideError() {
        isErrorHidden = true
        layoutIfNeeded()

        let animation = {
            self.border.updateColor(self.borderColor)
            self.errorView.alpha = 0.0
            self.errorIconView?.alpha = 0.0
            self.layoutIfNeeded()
        }

        let completion: (Bool) -> Void = { _ in
            self.errorView.isHidden = true
            self.errorIconView?.isHidden = true
        }

        UIView.animate(withDuration: animationDuration,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: animation,
                       completion: completion)
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

    func setupErrorIconView() {
        guard let errorIcon = errorIcon else {
            return
        }

        let errorIconView = UIImageView()
        errorIconView.image = errorIcon
        errorIconView.contentMode = .scaleAspectFit
        errorIconView.alpha = 0.0

        addSubview(errorIconView)

        errorIconView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            errorIconView.topAnchor.constraint(equalTo: topAnchor),
            errorIconView.bottomAnchor.constraint(equalTo: bottomAnchor),
            errorIconView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

        errorIconView.isHidden = true
        self.errorIconView = errorIconView
    }
}

public extension ETCustomErrorTextField {
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        super.textFieldDidBeginEditing(textField)

        // Update visibility of errorView
        if let errorIconView = errorIconView, self.shouldShowErrorViewOnFocusOnly == true {
            errorView.alpha = 0.0
            errorIconView.alpha = 1.0

            UIView.animate(withDuration: animationDuration) {
                self.errorView.alpha = 1.0
                errorIconView.alpha = 0.0
            }
        }
    }

    override func textFieldDidEndEditing(_ textField: UITextField) {
        super.textFieldDidEndEditing(textField)

        // Update visibility of errorView
        if let errorIconView = errorIconView, self.shouldShowErrorViewOnFocusOnly == true {
            errorView.alpha = 1.0
            errorIconView.alpha = 0.0

            UIView.animate(withDuration: animationDuration) {
                self.errorView.alpha = 0.0
                errorIconView.alpha = 1.0
            }
        }
    }
}
