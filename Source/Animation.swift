import Foundation

public struct Animation {
  
  public enum Curve {
    case Linear
    case Ease
    case EaseIn
    case EaseOut
    case EaseInOut
    case Bezier(Float, Float, Float, Float)
  }

  public enum Options {
    case Reverse
    case Repeat(Float)
  }

  public enum Spring {
    case Spring
    case Bounce
  }

  public enum Property: String {
    case PositionX = "position.x"
    case PositionY = "position.y"
    case Opacity = "opacity"
    case Origin = "position"
    case Width = "bounds.size.width"
    case Height = "bounds.size.height"
    case Size = "bounds.size"
    case Frame = "bounds"
    case CornerRadius = "cornerRadius"
    case Transform = "transform"
  }

  static func points(curve: Curve) -> [Float] {
    switch curve {
    case .Linear:
      return [0, 0, 1, 1]
    case .Ease:
      return [0.25, 0.1, 0.25, 1]
    case .EaseIn:
      return [0.42, 0, 1, 1]
    case .EaseOut:
      return [0, 0, 0.58, 1]
    case .EaseInOut:
      return [0.42, 0, 0.58, 1]
    case let .Bezier(x, y, z, p):
      return [x, y, z, p]
    }
  }

  static func propertyValue(property: Property, layer: CALayer) -> NSValue {
    switch property {
    case .PositionX:
      return layer.position.x
    case .PositionY:
      return layer.position.y
    case .Opacity:
      return layer.opacity
    case .Origin:
      return NSValue(CGPoint: layer.position)
    case .Width:
      return layer.bounds.width
    case .Height:
      return layer.bounds.height
    case .Size:
      return NSValue(CGSize: layer.bounds.size)
    case .Frame:
      return NSValue(CGRect: layer.frame)
    case .CornerRadius:
      return layer.cornerRadius
    case .Transform:
      return NSValue(CATransform3D: layer.transform)
    }
  }

  static func values(property: Property, to: NSValue, layer: CALayer) -> (finalValue: [CGFloat], initialValue: [CGFloat]) {
    switch property {
    case .PositionX:
      guard let to = to as? CGFloat else { return ([0], [layer.position.x]) }
      return ([to], [layer.position.x])
    case .PositionY:
      guard let to = to as? CGFloat else { return ([0], [layer.position.x]) }
      return ([to], [layer.position.y])
    case .Opacity:
      guard let to = to as? CGFloat else { return ([1], [1]) }
      return ([to], [CGFloat(layer.opacity)])
    case .Origin:
      return ([to.CGPointValue().x, to.CGPointValue().y], [layer.position.x, layer.position.y])
    case .Width:
      return ([to.CGSizeValue().width], [layer.bounds.width])
    case .Height:
      return ([to.CGSizeValue().height], [layer.bounds.height])
    case .Size:
      return ([to.CGSizeValue().width, to.CGSizeValue().height], [layer.bounds.width, layer.bounds.height])
    case .Frame:
      return ([to.CGRectValue().origin.x, to.CGRectValue().origin.y,
        to.CGRectValue().size.width, to.CGRectValue().size.height],
        [layer.position.x, layer.position.y, layer.frame.size.width, layer.frame.size.height])
    case .CornerRadius:
      return ([to as! CGFloat], [layer.cornerRadius])
    case .Transform:
      return ([to.CATransform3DValue.m11, to.CATransform3DValue.m12,
        to.CATransform3DValue.m13, to.CATransform3DValue.m14,
        to.CATransform3DValue.m21, to.CATransform3DValue.m22,
        to.CATransform3DValue.m23, to.CATransform3DValue.m24,
        to.CATransform3DValue.m31, to.CATransform3DValue.m32,
        to.CATransform3DValue.m33, to.CATransform3DValue.m34,
        to.CATransform3DValue.m41, to.CATransform3DValue.m42,
        to.CATransform3DValue.m43, to.CATransform3DValue.m44],

        [layer.transform.m11, layer.transform.m12, layer.transform.m13,
          layer.transform.m14, layer.transform.m21, layer.transform.m22,
          layer.transform.m23, layer.transform.m24, layer.transform.m31,
          layer.transform.m32, layer.transform.m33, layer.transform.m34,
          layer.transform.m41, layer.transform.m42, layer.transform.m43,
          layer.transform.m44])
    }
  }
}
