import UIKit
import Walker

class ViewController: UIViewController {

  struct Dimensions {
    static let viewSize: CGFloat = 80
    static let buttonHeight: CGFloat = 55
    static let buttonOffset: CGFloat = 120
  }

  struct Colors {
    static let mainColor = UIColor(red:0.04, green:0.57, blue:0.97, alpha:1)
    static let views = UIColor.whiteColor()
  }

  lazy var animationButton: UIButton = {
    let button = UIButton()
    button.layer.cornerRadius = 1.5
    button.layer.borderColor = UIColor.whiteColor().CGColor
    button.layer.borderWidth = 1.5
    button.setTitle("Start animations".uppercaseString, forState: .Normal)
    button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    button.addTarget(self, action: "animationButtonDidPress:", forControlEvents: .TouchUpInside)
    button.titleLabel?.font = UIFont.boldSystemFontOfSize(16)

    return button
  }()

  let totalWidth = UIScreen.mainScreen().bounds.width
  let totalHeight = UIScreen.mainScreen().bounds.height
  var views: [UIView] = []

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = Colors.mainColor

    setupViews(5)
    setupFrames()

    views.forEach { view.addSubview($0) }
    view.addSubview(animationButton)
  }

  // MARK: - Actions

  func animationButtonDidPress(button: UIButton) {
    let finalValue = views.first?.frame.origin.x == 25 ? totalWidth - Dimensions.viewSize - 50 : 25

    for (index, view) in views.enumerate() {

      switch index {
      case 0:
        animate(view) {
          $0.x = finalValue
        }
      case 1:
        spring(view, spring: 200, friction: 10, mass: 10) {
          $0.x = finalValue
        }
      case 2:
        animate(view) {
          $0.x = finalValue
        }.chain(duration: 0.5) {
          $0.alpha = 0
        }.chain(duration: 0.5) {
          $0.alpha = 1
        }
      case 3:
        animate(view, duration: 1, curve: .Bezier(1, 0.4, 1, 0.5)) {
          $0.x = finalValue
        }
      case 4:
        spring(view, delay: 0.5, spring: 800, friction: 10, mass: 10) {
          $0.x = finalValue
        }
      default:
        animate(view, curve: .EaseInOut) {
          $0.x = finalValue
        }
      }
    }
  }

  // MARK: - Configuration

  func setupViews(count: Int) {
    for index in 0..<count {
      let view = UIView()
      view.frame = CGRect(
        x: 25,
        y: 25 + (15 + Dimensions.viewSize) * CGFloat(index),
        width: Dimensions.viewSize,
        height: Dimensions.viewSize)

      view.layer.cornerRadius = 4
      view.backgroundColor = Colors.views

      views.append(view)
    }
  }

  func setupFrames() {
    animationButton.frame = CGRect(
      x: Dimensions.buttonOffset / 2,
      y: totalHeight - Dimensions.buttonHeight - 75,
      width: totalWidth - Dimensions.buttonOffset,
      height: Dimensions.buttonHeight)
  }

  // MARK: - UIStatusBar methods

  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return .LightContent
  }
}
