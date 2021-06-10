//
//  UILabel+Tappable.swift
//  TappableLabel
//
//  Created by Vid Tadel on 10/06/2021.
//

import ObjectiveC
import UIKit

public extension UILabel {
  private enum CallbackPropertyKey {
    static var callback: Int = 0
  }

  private var detectionCallback: ((URL) -> Void)? {
    get {
      objc_getAssociatedObject(self, &CallbackPropertyKey.callback) as? ((URL) -> Void)
    }
    set {
      objc_setAssociatedObject(self, &CallbackPropertyKey.callback, newValue, .OBJC_ASSOCIATION_COPY)
    }
  }

  func addLinkDetection(_ callback: @escaping (URL) -> Void) {
    isUserInteractionEnabled = true
    addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(labelTapped(_:))))
    detectionCallback = callback
  }

  @objc
  private func labelTapped(_ gestureRecognizer: UITapGestureRecognizer) {
    if let url = checkForLink(gestureRecognizer) {
      detectionCallback?(url)
    }
  }

  // thanks to https://stackoverflow.com/a/35789589/405770
  private func checkForLink(_ gestureRecognizer: UITapGestureRecognizer) -> URL? {
    let layoutManager = NSLayoutManager()
    let textContainer = NSTextContainer(size: CGSize.zero)
    let textStorage = NSTextStorage(attributedString: attributedText!)

    // Configure textContainer
    textContainer.lineFragmentPadding = 0.0
    textContainer.lineBreakMode = lineBreakMode
    textContainer.maximumNumberOfLines = numberOfLines
    let labelSize = bounds.size
    textContainer.size = labelSize

    // Configure layoutManager and textStorage
    layoutManager.addTextContainer(textContainer)
    textStorage.addLayoutManager(layoutManager)

    // Find the tapped character location and compare it to the specified range
    let locationOfTouchInLabel = gestureRecognizer.location(in: self)
    let textBoundingBox = layoutManager.usedRect(for: textContainer)

    let textContainerOffset = CGPoint(
      x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
      y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y
    )

    let locationOfTouchInTextContainer = CGPoint(
      x: locationOfTouchInLabel.x - textContainerOffset.x,
      y: locationOfTouchInLabel.y - textContainerOffset.y
    )
    guard textBoundingBox.contains(locationOfTouchInTextContainer) else {
      return nil
    }

    let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
    return attributedText?.attribute(.link, at: indexOfCharacter, effectiveRange: nil) as? URL
  }
}
