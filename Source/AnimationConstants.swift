import Foundation

public struct Animation {
  public enum Curve {
    case Linear
    case Ease
    case EaseIn
    case EaseOut
    case EaseInOut
  }

  public enum Spring {
    case Spring
    case Bounce
  }

  public enum Property: String {
    case PositionX = "position.x"
    case PositionY = "position.y"
    case Point = "position"
    case Width = "size.width"
    case Height = "size.height"
    case Size = "bounds.size"
    case Frame = "bounds"
    case CornerRadius = "cornerRadius"
    case Transform = "transform"
  }

  public static func bezierPoints(curve: Curve) -> [Float] {
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
      [0.42, 0, 0.58, 1]
    }
    return []
  }

  public static func propertyValue(property: Property, layer: CALayer) -> NSValue {
    switch property {
    case .PositionX:
      return layer.position.x
    case .PositionY:
      return layer.position.y
    case .Point:
      return NSValue(CGPoint: layer.position)
    case .Width:
      return layer.frame.width
    case .Height:
      return layer.frame.height
    case .Size:
      return NSValue(CGSize: layer.frame.size)
    case .Frame:
      return NSValue(CGRect: layer.frame)
    case .CornerRadius:
      return layer.cornerRadius
    case .Transform:
      return NSValue(CATransform3D: layer.transform)
    }
  }

  public static func values(property: Property, to: NSValue, layer: CALayer) -> (finalValue: [CGFloat], initialValue: [CGFloat]) {
    switch property {
    case .PositionX:
      return ([to as! CGFloat], [layer.position.x])
    case .PositionY:
      return ([to as! CGFloat], [layer.position.y])
    case .Point:
      return ([to.CGPointValue().x, to.CGPointValue().y], [layer.position.x, layer.position.y])
    case .Width:
      return ([to.CGSizeValue().width], [layer.frame.width])
    case .Height:
      return ([to.CGSizeValue().height], [layer.frame.height])
    case .Size:
      return ([to.CGSizeValue().width, to.CGSizeValue().height], [layer.frame.width, layer.frame.height])
    case .Frame:
      return ([to.CGRectValue().origin.x, to.CGRectValue().origin.y, to.CGRectValue().size.width, to.CGRectValue().size.height],
        [layer.position.x, layer.position.y, layer.frame.size.width, layer.frame.size.height])
    case .CornerRadius:
      return ([to as! CGFloat], [layer.cornerRadius])
    case .Transform:
      return ([], [])
    }
  }
}
