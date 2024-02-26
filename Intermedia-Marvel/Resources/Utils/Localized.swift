//
//  Localized.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 26/02/2024.
//

import UIKit
import SwiftUI

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: "IntermediaMarvelLocalizable", comment: "")
    }
}

class LocalizedLabel: UILabel {
    
    @IBInspectable var uppercased: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.text = uppercased ? text?.localized.uppercased() : text?.localized
    }
}

class LocalizedButton: UIButton {
    
    @IBInspectable var uppercased: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let buttonTitle = title(for: .normal)?.localized
        setTitle(uppercased ? buttonTitle?.uppercased() : buttonTitle, for: .normal)
    }
}

class LocalizedTextField: UITextField {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.placeholder = placeholder?.localized
    }
}

extension Text {
    public init<S>(localized text: S) where S : StringProtocol {
        let text = String(text)
        var translated = NSLocalizedString(text, comment: "")

        if translated == text {
            translated = NSLocalizedString(text, tableName: "IntermediaMarvelLocalizable",
                bundle: .main, value: text, comment: "")
        }
        self.init(verbatim: translated)
    }
}

