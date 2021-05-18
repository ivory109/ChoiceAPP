import UIKit

class Button: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderWidth = 2
        layer.cornerRadius = bounds.midY
        layer.borderColor = titleColor(for: .normal)?.cgColor
    }
}
