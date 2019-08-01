import UIKit

@IBDesignable class CircularButtonMinus: UIButton {

    @IBInspectable var borderColor: UIColor = UIColor.black
    @IBInspectable var borderWidth: CGFloat = 2

    @IBInspectable var minusColor: UIColor = UIColor.black
    @IBInspectable var minusWidth: CGFloat = 2
    @IBInspectable var minusRatio: CGFloat = 0.7

    override func draw(_ rect: CGRect) {
      drawCircleInRect(rect: rect, width: borderWidth, color: borderColor)
      drawHorizontalLineAtCenterOfRect(rect: rect, lineWidth: minusWidth, color: minusColor, ratio: minusRatio)
    }
}
