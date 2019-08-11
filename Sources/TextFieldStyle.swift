//
//  TextFieldStyle.swift
//  ETTextField-iOS
//
//  Created by Beles on 10/08/2019.
//  Copyright © 2019 ETTextField. All rights reserved.
//

import UIKit

public enum Border {
    case top, right, bottom, left
}

public struct TextFieldStyle {
    public var background: UIColor
    public var font: UIFont
    public var cornerRadius: CGFloat
    public var insets: UIEdgeInsets
    public var tintColor: UIColor
    public var border: [Border]
    public var borderColor: UIColor = .gray

    public init(background: UIColor = .clear,
                font: UIFont = UIFont.systemFont(ofSize: 12),
                tintColor: UIColor = .blue,
                cornerRadius: CGFloat = 0.0,
                insets: UIEdgeInsets = .zero,
                border: [Border] = [],
                borderColor: UIColor = .lightGray) {
        self.background = background
        self.font = font
        self.cornerRadius = cornerRadius
        self.insets = insets
        self.tintColor = tintColor
        self.border = border
        self.borderColor = borderColor
    }
}
