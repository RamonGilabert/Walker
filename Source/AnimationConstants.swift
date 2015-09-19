import Foundation

public struct Animation {
  public enum Curve {
    case Linear
    case Ease
    case EaseIn
    case EaseOut
    case EaseInOut
  }

  public enum Property: String {
    case PositionX = "position.x"
    case PositionY = "position.y"
    case Point = "position"
    case Width = "size.width"
    case Height = "size.height"
    case Size = "bounds.size"
    case Frame = "bounds"
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
    }
  }
}
