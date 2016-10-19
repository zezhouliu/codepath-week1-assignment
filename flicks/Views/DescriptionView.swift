//
//  DescriptionView.swift
//  flicks
//
//  Created by Alex Liu on 10/20/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class DescriptionView: UIStackView {

  // Lifecycle

  public init(frame: CGRect, title: String, description: String) {
    titleLabel = UILabel()
    descriptionLabel = UILabel()

    super.init(frame: frame)
    self.axis = .vertical
    self.distribution = .fillProportionally
    self.alignment = .top

    // Update title
    titleLabel.text = title
    titleLabel.font = titleLabel.font.withSize(24)
    titleLabel.textColor = UIColor.white
    titleLabel.numberOfLines = 0
    titleLabel.backgroundColor = transparentBackgroundColor

    // Update description
    descriptionLabel.text = description
    descriptionLabel.font = descriptionLabel.font.withSize(16)
    descriptionLabel.textColor = UIColor.white
    descriptionLabel.numberOfLines = 0
    descriptionLabel.backgroundColor = transparentBackgroundColor

    self.addArrangedSubview(titleLabel)
    self.addArrangedSubview(descriptionLabel)

    self.setupConstraints()

    titleLabel.sizeToFit()
    descriptionLabel.sizeToFit()
    self.sizeToFit()
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupConstraints() {

    // titleLabel
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true

    // descriptionLabel
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
    descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
  }

  // Private
  private let titleLabel: UILabel
  private let descriptionLabel: UILabel
  private let transparentBackgroundColor: UIColor = UIColor.init(colorLiteralRed: 0.1, green: 0.1, blue: 0.1, alpha: 0.9)
}
