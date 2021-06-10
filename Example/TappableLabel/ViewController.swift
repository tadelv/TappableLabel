//
//  ViewController.swift
//  TappableLabel
//
//  Created by tadelv on 06/10/2021.
//  Copyright (c) 2021 tadelv. All rights reserved.
//

import UIKit
import TappableLabel

class ViewController: UIViewController {
  private let label = UILabel()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupLabel()
    addLabelText()
    
    label.addLinkDetection { link in
      UIApplication.shared.open(link)
    }
  }
}

private extension ViewController {
  func setupLabel() {
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    view.addSubview(label)
    NSLayoutConstraint.activate([
      label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      label.topAnchor.constraint(equalTo: view.topAnchor),
      label.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }

  private var htmlData: Data {
    "Hello world!<br/><a href=\"https://www.github.com\">Click here</a> for Github.".data(using: .utf8) ?? Data()
  }

  func addLabelText() {
    guard let attributedString = try? NSMutableAttributedString(data: htmlData,
                                                                options: [.documentType: NSAttributedString.DocumentType.html],
                                                                documentAttributes: nil) else {
      print("Failed to create the attributed string!")
      return
    }
    attributedString.addAttribute(.font,
                                  value: UIFont.systemFont(ofSize: 15),
                                  range: .init(location: 0, length: attributedString.length))

    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .center
    attributedString.addAttribute(.paragraphStyle,
                                  value: paragraphStyle,
                                  range: .init(location: 0, length: attributedString.length))
    label.attributedText = attributedString
  }
}

