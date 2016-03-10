import UIKit
import Bakery

class ViewController: UIViewController {

  struct Dimensions {
    static let animationViewSize: CGFloat = 125
    static let buttonHeight: CGFloat = 55
    static let buttonOffset: CGFloat = 120
  }

  struct Colors {
    static let mainColor = UIColor(red:0.04, green:0.57, blue:0.97, alpha:1)
  }

  lazy var animationView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.whiteColor()
    view.layer.cornerRadius = 7.5

    return view
    }()

  lazy var animationButton: UIButton = {
    let button = UIButton()
    button.layer.cornerRadius = 1.5
    button.layer.borderColor = UIColor.whiteColor().CGColor
    button.layer.borderWidth = 1.5
    button.setTitle("Start animation".uppercaseString, forState: .Normal)
    button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    button.addTarget(self, action: "animationButtonDidPress:", forControlEvents: .TouchUpInside)
    button.titleLabel?.font = UIFont.boldSystemFontOfSize(16)

    return button
    }()

  let totalWidth = UIScreen.mainScreen().bounds.width
  let totalHeight = UIScreen.mainScreen().bounds.height

  override func viewDidLoad() {
    super.viewDidLoad()

    for subview in [animationView, animationButton] { view.addSubview(subview) }
    view.backgroundColor = Colors.mainColor

    setupFrames()
  }

  // MARK: - Actions

  func animationButtonDidPress(button: UIButton) {
    spring(animationView, spring: 200, friction: 10, mass: 10) {
      $0.y = 350
    }.chain(spring: 200, friction: 10, mass: 10) {
      $0.y = (self.totalHeight - Dimensions.animationViewSize) / 2 - 200
    }
  }

  // MARK: - Configuration

  func setupFrames() {
    animationView.frame = CGRect(
      x: (totalWidth - Dimensions.animationViewSize) / 2,
      y: (totalHeight - Dimensions.animationViewSize) / 2 - 200,
      width: Dimensions.animationViewSize,
      height: Dimensions.animationViewSize)

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
