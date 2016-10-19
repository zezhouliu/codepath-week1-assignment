//
//  MovieListViewController.swift
//  flicks
//
//  Created by Alex Liu on 10/17/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import Foundation
import UIKit

import MBProgressHUD

public enum MovieListSortingType {
  case NowPlaying
  case TopRated
}

final class MovieListViewController: BaseViewController {

  // Lifecycle

  init(sortingType: MovieListSortingType) {
    self.sortingType = sortingType

    tableView = UITableView(frame: UIScreen.main.bounds, style: UITableViewStyle.plain)
    dataSource = MovieListDataSource()
    refreshControl = UIRefreshControl()
    networkLabel = UILabel()

    super.init()

    edgesForExtendedLayout = []

    setupViews()
    setupTableViewConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    reloadData()
  }

  // Public

  public private(set) var sortingType: MovieListSortingType

  // Private

  private func setupViews() {
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.estimatedRowHeight = 45.0;
    tableView.dataSource = self
    tableView.delegate = self

    tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieCell")

    refreshControl.addTarget(self, action: #selector(MovieListViewController.reloadData), for: .valueChanged)
    tableView.addSubview(refreshControl)

    networkLabel.text = "Network Error"
    networkLabel.textAlignment = .center
    networkLabel.backgroundColor = UIColor.init(colorLiteralRed: 0.1, green: 0.1, blue: 0.1, alpha: 0.9)
    networkLabel.textColor = UIColor.white
    networkLabel.isHidden = true
    networkLabel.sizeToFit()

    self.view.addSubview(tableView)
    self.view.addSubview(networkLabel)
  }

  private func setupTableViewConstraints() {
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

    networkLabel.translatesAutoresizingMaskIntoConstraints = false
    networkLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    networkLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    networkLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

  }

  func reloadData() {
    // Display HUD right before the request is made
    MBProgressHUD.showAdded(to: self.tableView, animated: true)

    switch sortingType {
    case .NowPlaying:
      dataSource.loadNowPlayingMovies().then { _ -> Void in
        // Hide HUD once the network request comes back (must be done on main UI thread)
        MBProgressHUD.hide(for: self.tableView, animated: true)
        self.refreshControl.endRefreshing()
        self.networkLabel.isHidden = true

        self.tableView.reloadData()
        } .catch { error in
          // Hide HUD once the network request comes back (must be done on main UI thread)
          MBProgressHUD.hide(for: self.tableView, animated: true)
          self.refreshControl.endRefreshing()
          self.networkLabel.isHidden = false
      }
    case .TopRated:
      dataSource.loadTopMovies().then { _ -> Void in
        // Hide HUD once the network request comes back (must be done on main UI thread)
        MBProgressHUD.hide(for: self.tableView, animated: true)
        self.refreshControl.endRefreshing()
        self.networkLabel.isHidden = true

        self.tableView.reloadData()
        } .catch { error in
          // Hide HUD once the network request comes back (must be done on main UI thread)
          MBProgressHUD.hide(for: self.tableView, animated: true)
          self.refreshControl.endRefreshing()
          self.networkLabel.isHidden = false
      }
    }
  }

  // Internal

  internal let dataSource: MovieListDataSource
  internal let refreshControl: UIRefreshControl

  // Private

  private var tableView: UITableView
  private var networkLabel: UILabel
}

extension MovieListViewController: UITableViewDataSource {

  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.dataSource.movies.count;
  }

  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)
    if let movieTableViewCell = cell as? MovieTableViewCell {
      movieTableViewCell.setContent(content: MovieTableViewCellContent(movie: self.dataSource.movies[indexPath.row]))
      return movieTableViewCell
    }
    return cell
  }
}

extension MovieListViewController: UITableViewDelegate {

  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let content = MovieDetailsContent(movie: self.dataSource.movies[indexPath.row])
    let detailsViewController = MovieDetailsViewController(content: content)

    navigationController?.pushViewController(detailsViewController, animated: true)
  }

}
