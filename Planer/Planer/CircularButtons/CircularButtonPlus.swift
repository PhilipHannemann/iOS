import UIKit

@IBDesignable class CircularButtonPlus: UIButton {

    @IBInspectable var borderColor: UIColor = UIColor.black
    @IBInspectable var borderWidth: CGFloat = 2

    @IBInspectable var plusColor: UIColor = UIColor.black
    @IBInspectable var plusWidth: CGFloat = 2
    @IBInspectable var plusRatio: CGFloat = 0.7

    override func draw(_ rect: CGRect) {
      drawCircleInRect(rect: rect, width: borderWidth, color: borderColor)
      drawPlusAtCenterOfRect(rect: rect, lineWidth: plusWidth, color: plusColor, ratio: plusRatio)
    }
}
