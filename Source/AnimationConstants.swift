import Foundation

public struct Animation {
  public enum Curve: AnimationConstant.CurvePoints {
    case Linear = Animat
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
}

public struct AnimationConstant: RawRepresentable {
  public struct CurvePoints {
    public struct Linear {
      static let firstX: Float = 0
      static let firstY: Float = 0
      static let secondX: Float = 1
      static let secondY: Float = 1
    }

    public struct Ease {
      static let firstX: Float = 0.25
      static let firstY: Float = 0.1
      static let secondX: Float = 0.25
      static let secondY: Float = 1
    }

    public struct EaseIn {
      static let firstX: Float = 0.42
      static let firstY: Float = 0
      static let secondX: Float = 1
      static let secondY: Float = 1
    }

    public struct EaseOut {
      static let firstX: Float = 0
      static let firstY: Float = 0
      static let secondX: Float = 0.58
      static let secondY: Float = 1
    }

    public struct EaseInOut {
      static let firstX: Float = 0.42
      static let firstY: Float = 0
      static let secondX: Float = 0.58
      static let secondY: Float = 1
    }
  }
}
