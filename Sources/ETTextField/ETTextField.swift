//
//  ETTextField.swift
//  ETTextField
//
//  Created by Miroslav Beles on 10/08/2019.
//  Copyright © 2019 ETTextField. All rights reserved.
//

import UIKit
import ETBinding

open class ETTextField: UITextField {

    // MARK: - Variables
    // MARK: public

    public let onDidBeginEditing = FutureEvent<Void>()
    public let onDidEndEditing = FutureEvent<Void>()
    public let onReturnKeyPressed = FutureEvent<Void>()
    public let onDidChangeText = LiveOptionalData<String>()
    public var style: TextFieldStyle = TextFieldStyle()
    public var insets: UIEdgeInsets = .zero
    public var title: String? = nil {
        didSet {
            titleLabel.text = title
        }
    }
    public var titleOffset: CGFloat = 0.0 {
        didSet {
            titleLabelShowConstraint?.constant = titleOffset
        }
    }
    override open var placeholder: String? {
        didSet {
            attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: style.placeholderColor])
        }
    }
    override open var isEnabled: Bool {
        didSet {
            update(with: style)
        }
    }

    // MARK: private

    private let animationDuration: TimeInterval = 0.2
    private let errorColor: UIColor = .red
    private var isErrorHidden: Bool = true
    private var border = TextFieldBorder()
    private let backgroundView = UIView()
    private let titleLabel = UILabel()
    private let errorLabel = UILabel()
    private var titleLabelShowConstraint: NSLayoutConstraint?
    private var titleLabelHideConstraint: NSLayoutConstraint?
    private var titleLabelLeftConstraint: NSLayoutConstraint?
    private var errorLabelShowConstraint: NSLayoutConstraint?
    private var errorLabelHideConstraint: NSLayoutConstraint?
    private var errorLabelLeftConstraint: NSLayoutConstraint?
    private var isTitleHidden: Bool = true
    private var borderColor: UIColor

    // MARK: - Initialization

    public init(style: TextFieldStyle = TextFieldStyle()) {
        self.style = style
        self.borderColor = style.borderColor
        super.init(frame: .zero)

        setupContent()
        update(with: style)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Content

    private func setupContent() {
        backgroundView.clipsToBounds = true
        delegate = self
        addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        setupBackground()
        setupTitleLabel()
        setupErrorLabel()
    }

    private func setupBackground() {
        backgroundView.isUserInteractionEnabled = false
        addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        backgroundView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        backgroundView.addSubview(border)
        border.translatesAutoresizingMaskIntoConstraints = false
        border.topAnchor.constraint(equalTo: backgroundView.topAnchor).isActive = true
        border.leftAnchor.constraint(equalTo: backgroundView.leftAnchor).isActive = true
        border.rightAnchor.constraint(equalTo: backgroundView.rightAnchor).isActive = true
        border.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor).isActive = true
    }

    private func setupErrorLabel() {
        errorLabel.alpha = 0.0
        errorLabel.font = UIFont.systemFont(ofSize: 12)
        errorLabel.textColor = errorColor

        addSubview(errorLabel)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false

        errorLabelHideConstraint = errorLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        errorLabelShowConstraint = errorLabel.topAnchor.constraint(equalTo: bottomAnchor)
        errorLabelLeftConstraint = errorLabel.leftAnchor.constraint(equalTo: leftAnchor)

        errorLabelLeftConstraint?.isActive = true
        errorLabelHideConstraint?.isActive = true
        errorLabelShowConstraint?.isActive = false
    }

    private func setupTitleLabel() {
        titleLabel.alpha = 0.0
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textColor = .black

        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        titleLabelHideConstraint = titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        titleLabelShowConstraint = titleLabel.bottomAnchor.constraint(equalTo: topAnchor, constant: titleOffset)
        titleLabelLeftConstraint = titleLabel.leftAnchor.constraint(equalTo: leftAnchor)

        titleLabelLeftConstraint?.isActive = true
        titleLabelHideConstraint?.isActive = true
        titleLabelShowConstraint?.isActive = false
    }


    // MARK: - Customization

    open func update(with style: TextFieldStyle) {
        self.style = style
        backgroundView.backgroundColor = style.background
        font = style.font
        backgroundView.layer.cornerRadius = style.cornerRadius
        insets = style.insets

        if let disabledColor = style.disabledTintColor, !isEnabled {
            tintColor = disabledColor
            borderColor = disabledColor
        } else {
            tintColor = style.tintColor
            borderColor = style.borderColor
        }

        border.update(with: TextFieldBorder.Style(
            sides: style.border,
            color: isErrorHidden ? borderColor : errorColor,
            width: style.borderWidth,
            cornerRadius: style.cornerRadius
        ))

        titleLabel.textColor = tintColor
        titleLabel.backgroundColor = style.titleBackground
        titleLabelLeftConstraint?.constant = style.insets.left
        errorLabelLeftConstraint?.constant = style.insets.left
    }

    // MARK: - Actions

    open func showError(message: String) {
        errorLabel.text = message
        self.layoutIfNeeded()
        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseIn, animations: {
            if self.isEnabled || self.style.disabledTintColor == nil {
                self.border.updateColor(self.errorColor)
            }

            self.errorLabelHideConstraint?.isActive = false
            self.errorLabelShowConstraint?.isActive = true
            self.errorLabel.alpha = 1.0
            self.layoutIfNeeded()
        }, completion: { _ in
            self.isErrorHidden = false
        })
    }

    open func hideError() {
        errorLabel.text = nil
        self.layoutIfNeeded()
        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseOut, animations: {
            self.border.updateColor(self.borderColor)
            self.errorLabelHideConstraint?.isActive = true
            self.errorLabelShowConstraint?.isActive = false
            self.errorLabel.alpha = 0.0
            self.layoutIfNeeded()
        }, completion: { _ in
            self.isErrorHidden = true
        })
    }

    open func showTitle() {
        guard style.showTitle == true, isTitleHidden == true else {
            return
        }

        UIView.animate(withDuration: animationDuration, delay: 0,
                       options: .curveEaseIn,
                       animations: {
                        self.titleLabelHideConstraint?.isActive = false
                        self.titleLabelShowConstraint?.isActive = true
                        self.titleLabel.alpha = 1.0
                        self.layoutIfNeeded()
        }, completion: { _ in
            self.isTitleHidden = false
        })
    }

    open func hideTitle() {
        guard isTitleHidden == false else {
            return
        }

        UIView.animate(withDuration: animationDuration, delay: 0,
                       options: .curveEaseOut,
                       animations: {
                        self.titleLabelHideConstraint?.isActive = true
                        self.titleLabelShowConstraint?.isActive = false
                        self.titleLabel.alpha = 0.0
                        self.layoutIfNeeded()
        }, completion: { _ in
            self.isTitleHidden = true
        })
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }

    @objc func textFieldDidChange(_ textField: UITextField) {

        if isErrorHidden == false {
            hideError()
        }

        if textField.text?.isEmpty == false {
            showTitle()
        } else {
            hideTitle()
        }

        onDidChangeText.data = textField.text
    }
}

extension ETTextField: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        onReturnKeyPressed.trigger()
        return true
    }

    public func textFieldDidBeginEditing(_ textField: UITextField) {
        onDidBeginEditing.trigger()
    }

    public func textFieldDidEndEditing(_ textField: UITextField) {
        onDidEndEditing.trigger()
    }
}
