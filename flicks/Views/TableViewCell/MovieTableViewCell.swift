//
//  MovieTableViewCell.swift
//  flicks
//
//  Created by Alex Liu on 10/18/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import Foundation
import UIKit

import AFNetworking

public struct MovieTableViewCellContent {

  init(title: String, description: String, imageURL: URL) {
    self.title = title
    self.description = description
    self.imageURL = imageURL
  }

  init(movie: FlicksMovie) {
    self.title = movie.title
    self.description = movie.overview
    self.imageURL = movie.posterPath != nil ?
      URL(string: "https://image.tmdb.org/t/p/w300" + movie.posterPath!) :
      nil
  }

  let title: String?
  let description: String?
  let imageURL: URL?

}

public class MovieTableViewCell: UITableViewCell {

  // Lifecycle
  public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    posterImageView = UIImageView()
    movieTitleLabel = UILabel()
    movieDescriptionLabel = UILabel()

    super.init(style: style, reuseIdentifier: reuseIdentifier)

    self.setupViews()
    self.setupConstraints()
  }
  
  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // Public
  public func setContent(content: MovieTableViewCellContent) {
    if let imageURL = content.imageURL {
      posterImageView.setImageWith(imageURL)
    }
    if let title = content.title {
      movieTitleLabel.text = title
    }
    if let desc = content.description {
      movieDescriptionLabel.text = desc
    }
  }

  // Private
  private func setupViews() {
    posterImageView.image = UIImage(named: "popcorn")

    movieTitleLabel.text = "TODO(title)"
    movieTitleLabel.font = movieTitleLabel.font.withSize(20)
    movieTitleLabel.numberOfLines = 0

    movieDescriptionLabel.text = "TODO(desc)"
    movieDescriptionLabel.font = movieDescriptionLabel.font.withSize(14)
    movieDescriptionLabel.numberOfLines = 0

    self.contentView.addSubview(posterImageView)
    self.contentView.addSubview(movieTitleLabel)
    self.contentView.addSubview(movieDescriptionLabel)
  }

  private func setupConstraints() {
    let margins = contentView.layoutMarginsGuide

    posterImageView.translatesAutoresizingMaskIntoConstraints = false
    posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
//    posterImageView.contentMode = .scaleAspectFit
    posterImageView.heightAnchor.constraint(equalToConstant: 135).isActive = true
    posterImageView.widthAnchor.constraint(equalToConstant: 90).isActive = true

    movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    movieTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    movieTitleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 4).isActive = true
    movieTitleLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true

    movieDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    movieDescriptionLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor).isActive = true
    movieDescriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor).isActive = true
    movieDescriptionLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 4).isActive = true
    movieDescriptionLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true

  }

  private var posterImageView: UIImageView
  private var movieTitleLabel: UILabel
  private var movieDescriptionLabel: UILabel

}
