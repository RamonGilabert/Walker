import UIKit

public struct Animator {

  public static func shake<T : UIView>(view: T, landscape: Bool = true) {
    let duration = 0.075
    let x: CGFloat = landscape ? 25 : 0
    let y: CGFloat = landscape ? 0 : 25

    UIView.animateWithDuration(duration, animations: {
      view.layer.transform = CATransform3DMakeTranslation(-x, -y, 0)
      }, completion: { _ in
        UIView.animateWithDuration(duration, animations: {
          view.layer.transform = CATransform3DMakeTranslation(x, y, 0)
          }, completion: { _ in
            UIView.animateWithDuration(duration, animations: {
              view.layer.transform = CATransform3DMakeTranslation(-x / 2, -y / 2, 0)
              }, completion: { _ in
                UIView.animateWithDuration(duration, animations: {
                  view.layer.transform = CATransform3DIdentity
                })
            })
        })
    })
  }

  public static func levitate<T : UIView>(view: T) {
    UIView.animateWithDuration(0.35, animations: {
      view.layer.transform = CATransform3DTranslate(CATransform3DMakeScale(0.95, 0.95, 0.95), 0, 0, -1)
      }, completion: { finished in
        if !finished { return }
        UIView.animateWithDuration(0.5, delay: 0, options: [.Autoreverse, .Repeat, .BeginFromCurrentState], animations: {
          view.layer.transform = CATransform3DTranslate(CATransform3DMakeScale(0.975, 0.975, 0.975), 0, 0, -1)
          }, completion: nil)
    })
  }

  public static func pushDown<T : UIView>(view: T) {
    UIView.animateWithDuration(0.1, animations: {
      view.transform = CGAffineTransformMakeScale(0.9, 0.9)
      }, completion: { _ in
        UIView.animateWithDuration(0.05, animations: {
          view.transform = CGAffineTransformIdentity
        })
    })
  }

  public static func pushUp<T : UIView>(view: T) {
    UIView.animateWithDuration(0.1, animations: {
      view.transform = CGAffineTransformMakeScale(1.1, 1.1)
      }, completion: { _ in
        UIView.animateWithDuration(0.05, animations: {
          view.transform = CGAffineTransformIdentity
        })
    })
  }

  public static func fadeRemove<T : UIView>(view: T) {
    UIView.animateWithDuration(0.4, animations: {
      view.alpha = 0
      }, completion: { _ in
        view.removeFromSuperview()
    })
  }

  public static func peek<T: UIView>(view: T) {
    UIView.animateWithDuration(0.65, delay: 0, usingSpringWithDamping: 0.65, initialSpringVelocity: 0.65, options: [], animations: {
      view.transform = CGAffineTransformIdentity
      }, completion: nil)
  }

  public static func flip<T : UIView>(view: T, subview: T, right: Bool = true, duration: NSTimeInterval = 0.6, completion: (() -> Void)? = nil) {
    let options: UIViewAnimationOptions = right ? .TransitionFlipFromRight : .TransitionFlipFromLeft

    UIView.transitionFromView(view, toView: subview, duration: duration, options: [options, .BeginFromCurrentState, .OverrideInheritedOptions], completion: { _ in
      completion?()
    })
  }

  public static func float<T: UIView>(view: T) {
    let duration: NSTimeInterval = 0.75

    UIView.animateWithDuration(duration, delay: 0, options: [.BeginFromCurrentState], animations: {
      view.transform = CGAffineTransformMakeScale(1.025, 1.025)
      }, completion: { _ in
        UIView.animateWithDuration(duration, delay: 0, options: [.Autoreverse, .Repeat, .BeginFromCurrentState], animations: {
          view.transform = CGAffineTransformMakeScale(0.975, 0.975)
          }, completion: nil)
    })
  }

  public static func pushButtonDown(button: UIButton) {
    guard let imageView = button.imageView else { return }
    pushDown(imageView)
  }

  public static func pushButtonUp(button: UIButton) {
    guard let imageView = button.imageView else { return }
    pushUp(imageView)
  }
}
