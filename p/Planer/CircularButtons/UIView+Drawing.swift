import UIKit

/*
 A `UIView` extension adding some drawing methods
 */
extension UIView {
    func drawCircleInRect(rect: CGRect, width: CGFloat, color: UIColor) {
      let insetRect = rect.insetBy(dx: width/2, dy: width/2)
      let borderPath = UIBezierPath(ovalIn: insetRect)
        borderPath.lineWidth = width
        color.setStroke()
        borderPath.stroke()
    }

    func drawHorizontalLineAtCenterOfRect(rect: CGRect, lineWidth: CGFloat, color: UIColor, ratio: CGFloat) {
        let path = UIBezierPath()
        let width: CGFloat = min(bounds.width, bounds.height) * ratio
        path.lineWidth = lineWidth
        path.move(to: CGPoint(x: bounds.width / 2 - width / 2, y: bounds.height / 2))
        path.addLine(to: CGPoint(x: bounds.width / 2 + width / 2, y: bounds.height / 2))

        color.setStroke()
        path.stroke()
    }

    func drawVerticalLineAtCenterOfRect(rect: CGRect, lineWidth: CGFloat, color: UIColor, ratio: CGFloat) {
        let path = UIBezierPath()
        let height: CGFloat = min(bounds.width, bounds.height) * ratio
        path.lineWidth = lineWidth
        path.move(to: CGPoint(x: bounds.width / 2, y: bounds.height / 2 - height / 2))
        path.addLine(to: CGPoint(x: bounds.width / 2, y: bounds.height / 2 + height / 2))

        color.setStroke()
        path.stroke()
    }

    func drawPlusAtCenterOfRect(rect: CGRect, lineWidth: CGFloat, color: UIColor, ratio: CGFloat) {
        drawHorizontalLineAtCenterOfRect(rect: rect, lineWidth: lineWidth, color: color, ratio: ratio)
        drawVerticalLineAtCenterOfRect(rect: rect, lineWidth: lineWidth, color: color, ratio: ratio)
    }
}
