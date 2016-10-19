//
//  MovieDetailsViewController.swift
//  flicks
//
//  Created by Alex Liu on 10/20/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

public struct MovieDetailsContent {

  init(title: String, description: String, imageURL: URL) {
    self.title = title
    self.description = description
    self.imageURL = imageURL
  }

  init(movie: FlicksMovie) {
    self.title = movie.title
    self.description = movie.overview
    self.imageURL = movie.posterPath != nil ?
      URL(string: "https://image.tmdb.org/t/p/w1000" + movie.posterPath!) :
    nil
  }

  let title: String?
  let description: String?
  let imageURL: URL?
}

class MovieDetailsViewController: BaseViewController {

  init(content: MovieDetailsContent) {
    self.content = content
    self.scrollView = UIScrollView()
    self.posterImageView = UIImageView()
    self.descriptionView = DescriptionView(
      frame: CGRect.zero,
      title: content.title!,
      description: content.description!)
    self.contentView = UIView()

    super.init()

    edgesForExtendedLayout = []

    setupViews()
    setupConstraints()
  }
  
  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    navigationController?.hidesBottomBarWhenPushed = true
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  private func setupViews() {

    // ScrollView
    scrollView.delegate = self
    scrollView.clipsToBounds = true

    // posterImageView
    if let url = content.imageURL {
      self.posterImageView.setImageWith(url)
      self.posterImageView.contentMode = .scaleAspectFit
      self.posterImageView.sizeToFit()
    }

    // TODO(descriptionLabel)

    self.view.addSubview(posterImageView)
    self.view.addSubview(scrollView)

    contentView.addSubview(descriptionView)
    scrollView.addSubview(contentView)
  }

  private func setupConstraints() {

    // scrollView
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
//    scrollView.heightAnchor.constraint(equalToConstant: self.view.frame.height / 2 ).isActive = true

    // imageView
    posterImageView.translatesAutoresizingMaskIntoConstraints = false
    posterImageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    posterImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    posterImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    posterImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

    // contentView
    contentView.translatesAutoresizingMaskIntoConstraints = false
    contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
    contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
    contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
    // Create extra bounds so we can get "scrolling" action
    contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -50).isActive = true
    contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
    contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true

    // descriptionView
    descriptionView.translatesAutoresizingMaskIntoConstraints = false
    descriptionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
    descriptionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
    descriptionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
    descriptionView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 20).isActive = true
  }

  // Internal

  internal let content: MovieDetailsContent
  internal let scrollView: UIScrollView
  internal let posterImageView: UIImageView
  internal let descriptionView: DescriptionView
  internal let contentView: UIView
}

extension MovieDetailsViewController: UIScrollViewDelegate {
  
}
