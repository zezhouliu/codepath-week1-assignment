//
//  MovieListDataSource.swift
//  flicks
//
//  Created by Alex Liu on 10/18/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import Foundation
import PromiseKit

enum MovieListError: Error {
  case TimedOut
  case Failed
}

class MovieListDataSource {

  // Lifecycle

  init() {
    movies = []
  }

  public func loadTopMovies() -> Promise<Void> {
    return Promise<Void> { fulfill, reject in
      let requester = FlicksRequester()
      requester.getTopMovies(page: 0, completion: { dictionary in
        if let moviesArray = dictionary["results"] as? [[String: AnyObject]] {
          var newMovies: [FlicksMovie] = []
          for movie in moviesArray {
            newMovies.append(FlicksMovie(JSON: movie)!)
          }
          self.movies = newMovies
          fulfill()
        } else {
          reject(MovieListError.Failed)
        }
      })
    }
  }

  public func loadNowPlayingMovies() -> Promise<Void> {
    return Promise<Void> { fulfill, reject in
      let requester = FlicksRequester()
      requester.getNowPlayingMovies(page: 0, completion: { dictionary in
        if let moviesArray = dictionary["results"] as? [[String: AnyObject]] {
          var newMovies: [FlicksMovie] = []
          for movie in moviesArray {
            newMovies.append(FlicksMovie(JSON: movie)!)
          }
          self.movies = newMovies
          fulfill()
        } else {
          reject(MovieListError.Failed)
        }
      })
    }
  }

  public private(set) var movies: [FlicksMovie]
}
