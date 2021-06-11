import XCTest
@testable import TappableLabel

class Tests: XCTestCase {
  func testPerformance() {
    // This is an example of a performance test case.
    let label = UILabel()
    label.text = "test text"
    label.sizeToFit()
    label.addLinkDetection { _ in }
    let recognizer = label.gestureRecognizers?.first
    let measureOptions = XCTMeasureOptions.default
    measureOptions.iterationCount = 100

    if #available(iOS 13.0, *) {
      self.measure(options: measureOptions) {
        recognizer?.execute()
      }
    } else {
      self.measure {
        recognizer?.execute()
      }
    }
  }

  func testNilText() {
    let label = UILabel()
    label.text = nil
    label.sizeToFit()
    label.addLinkDetection { _ in }
    let recognizer = label.gestureRecognizers?.first
    XCTAssertNoThrow(recognizer?.execute())
  }
}

// Return type alias
public typealias TargetActionInfo = [(target: AnyObject, action: Selector)]

// UIGestureRecognizer extension
extension  UIGestureRecognizer {

  // MARK: Retrieving targets from gesture recognizers

  /// Returns all actions and selectors for a gesture recognizer
  /// This method uses private API's and will most likely cause your app to be rejected if used outside of your test target
  /// - Returns: [(target: AnyObject, action: Selector)] Array of action/selector tuples
  public func getTargetInfo() -> TargetActionInfo {
    var targetsInfo: TargetActionInfo = []

    if let targets = self.value(forKeyPath: "_targets") as? [NSObject] {
      for target in targets {
        // Getting selector by parsing the description string of a UIGestureRecognizerTarget
        let selectorString = String.init(describing: target).components(separatedBy: ", ").first!.replacingOccurrences(of: "(action=", with: "")
        let selector = NSSelectorFromString(selectorString)

        // Getting target from iVars
        let targetActionPairClass: AnyClass = NSClassFromString("UIGestureRecognizerTarget")!
        let targetIvar: Ivar = class_getInstanceVariable(targetActionPairClass, "_target")!
        let targetObject: AnyObject = object_getIvar(target, targetIvar) as AnyObject

        targetsInfo.append((target: targetObject, action: selector))
      }
    }

    return targetsInfo
  }

  /// Executes all targets on a gesture recognizer
  public func execute() {
    let targetsInfo = self.getTargetInfo()
    for info in targetsInfo {
      info.target.performSelector(onMainThread: info.action, with: self, waitUntilDone: true)
    }
  }

}
