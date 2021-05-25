//
//  AnimatedTextField.swift
//  Roll
//
//  Created by tagline13 on 25/06/20.
//  Copyright © 2020 tagline13. All rights reserved.
//

import UIKit
import TweeTextField

class AnimatedTextField: TweeAttributedTextField {
    
    /// :nodoc:
    override func awakeFromNib() {
        super.awakeFromNib()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(startEditing),
            name: UITextField.textDidBeginEditingNotification,
            object: self
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(endEditingText),
            name: UITextField.textDidEndEditingNotification,
            object: self
        )
    }

    @objc private func startEditing() {
        placeholderLabel.textColor = .red
    }

    @objc private func endEditingText() {
        if let text = text, !text.isEmpty {
            placeholderLabel.textColor = .red
        } else {
            placeholderLabel.textColor = .gray
        }
    }
}
