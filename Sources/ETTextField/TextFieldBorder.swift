//
//  TextFieldBorder.swift
//  ETTextField-iOS
//
//  Created by Lukas Ambroz on 17/06/2020.
//  Copyright © 2020 ETTextField. All rights reserved.
//

import UIKit

class TextFieldBorder: UIView {

    struct Style {
        var sides: [Border]
        var color: UIColor
        var width: CGFloat = 1.0
        var cornerRadius: CGFloat = 0.0
    }

    private var top: UIView?
    private var bottom: UIView?
    private var left: UIView?
    private var right: UIView?
    private var all: UIView?

    func update(with style: Style) {
        clear()

        style.sides.forEach {
            addLine(to: $0, with: style)
        }
    }

    func updateColor(_ color: UIColor) {
        top?.backgroundColor = color
        bottom?.backgroundColor = color
        left?.backgroundColor = color
        right?.backgroundColor = color
        all?.layer.borderColor = color.cgColor
    }

    private func addLine(to side: Border, with style: Style) {
        clearLine(side)

        let border = UIView()
        addSubview(border)
        border.translatesAutoresizingMaskIntoConstraints = false

        switch side {
        case .top:
            top = border
            border.backgroundColor = style.color
            border.topAnchor.constraint(equalTo: topAnchor).isActive = true
            border.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            border.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            border.heightAnchor.constraint(equalToConstant: style.width).isActive = true
        case .bottom:
            bottom = border
            border.backgroundColor = style.color
            border.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            border.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            border.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            border.heightAnchor.constraint(equalToConstant: style.width).isActive = true
        case .left:
            left = border
            border.backgroundColor = style.color
            border.topAnchor.constraint(equalTo: topAnchor).isActive = true
            border.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            border.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            border.widthAnchor.constraint(equalToConstant: style.width).isActive = true
        case .right:
            right = border
            border.backgroundColor = style.color
            border.topAnchor.constraint(equalTo: topAnchor).isActive = true
            border.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            border.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            border.widthAnchor.constraint(equalToConstant: style.width).isActive = true
        case .all:
            all = border
            border.backgroundColor = .clear
            border.layer.borderColor = style.color.cgColor
            border.layer.borderWidth = style.width
            border.layer.cornerRadius = style.cornerRadius
            border.topAnchor.constraint(equalTo: topAnchor).isActive = true
            border.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            border.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            border.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        }
    }

    private func clear() {
        [Border.top, Border.bottom, Border.left, Border.right, Border.all].forEach {
            clearLine($0)
        }
    }

    private func clearLine(_ side: Border) {
        switch side {
        case .top:
            top?.removeFromSuperview()
            top = nil
        case .bottom:
            bottom?.removeFromSuperview()
            bottom = nil
        case .left:
            left?.removeFromSuperview()
            left = nil
        case .right:
            right?.removeFromSuperview()
            right = nil
        case .all:
            all?.removeFromSuperview()
            all = nil
        }
    }
}
