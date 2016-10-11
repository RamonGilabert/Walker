import UIKit

public struct Animation {
  
  public enum Curve {
    case linear
    case ease
    case easeIn
    case easeOut
    case easeInOut
    case bezier(Float, Float, Float, Float)
  }

  public enum Options {
    case reverse
    case `repeat`(Float)
  }

  public enum Spring {
    case spring
    case bounce
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

  static func points(_ curve: Curve) -> [Float] {
    switch curve {
    case .linear:
      return [0, 0, 1, 1]
    case .ease:
      return [0.25, 0.1, 0.25, 1]
    case .easeIn:
      return [0.42, 0, 1, 1]
    case .easeOut:
      return [0, 0, 0.58, 1]
    case .easeInOut:
      return [0.42, 0, 0.58, 1]
    case let .bezier(x, y, z, p):
      return [x, y, z, p]
    }
  }

  static func propertyValue(_ property: Property, layer: CALayer) -> NSValue {
    switch property {
    case .PositionX:
      return layer.position.x as NSValue
    case .PositionY:
      return layer.position.y as NSValue
    case .Opacity:
      return layer.opacity as NSValue
    case .Origin:
      return NSValue(cgPoint: layer.position)
    case .Width:
      return layer.bounds.width as NSValue
    case .Height:
      return layer.bounds.height as NSValue
    case .Size:
      return NSValue(cgSize: layer.bounds.size)
    case .Frame:
      return NSValue(cgRect: layer.frame)
    case .CornerRadius:
      return layer.cornerRadius as NSValue
    case .Transform:
      return NSValue(caTransform3D: layer.transform)
    }
  }

  static func values(_ property: Property, to: NSValue, layer: CALayer) -> (finalValue: [CGFloat], initialValue: [CGFloat]) {
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
      return ([to.cgPointValue.x, to.cgPointValue.y], [layer.position.x, layer.position.y])
    case .Width:
      return ([to.cgSizeValue.width], [layer.bounds.width])
    case .Height:
      return ([to.cgSizeValue.height], [layer.bounds.height])
    case .Size:
      return ([to.cgSizeValue.width, to.cgSizeValue.height], [layer.bounds.width, layer.bounds.height])
    case .Frame:
      return ([to.cgRectValue.origin.x, to.cgRectValue.origin.y,
        to.cgRectValue.size.width, to.cgRectValue.size.height],
        [layer.position.x, layer.position.y, layer.frame.size.width, layer.frame.size.height])
    case .CornerRadius:
      return ([to as! CGFloat], [layer.cornerRadius])
    case .Transform:
      return ([to.caTransform3DValue.m11, to.caTransform3DValue.m12,
        to.caTransform3DValue.m13, to.caTransform3DValue.m14,
        to.caTransform3DValue.m21, to.caTransform3DValue.m22,
        to.caTransform3DValue.m23, to.caTransform3DValue.m24,
        to.caTransform3DValue.m31, to.caTransform3DValue.m32,
        to.caTransform3DValue.m33, to.caTransform3DValue.m34,
        to.caTransform3DValue.m41, to.caTransform3DValue.m42,
        to.caTransform3DValue.m43, to.caTransform3DValue.m44],

        [layer.transform.m11, layer.transform.m12, layer.transform.m13,
          layer.transform.m14, layer.transform.m21, layer.transform.m22,
          layer.transform.m23, layer.transform.m24, layer.transform.m31,
          layer.transform.m32, layer.transform.m33, layer.transform.m34,
          layer.transform.m41, layer.transform.m42, layer.transform.m43,
          layer.transform.m44])
    }
  }
}
