//
//  FlicksRequester.swift
//  flicks
//
//  Created by Alex Liu on 10/18/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import Foundation
// TODO(alex): Create BaseRequester class
final public class FlicksRequester {

  private static let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
  private static let nowPlayingUrl = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
  private static let topMoviesUrl = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=\(apiKey)")

  public func getNowPlayingMovies(page: Int, completion: @escaping (AnyObject) -> Void) {
    let request = URLRequest(
      url: FlicksRequester.nowPlayingUrl!,
      cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalCacheData,
      timeoutInterval: 10)

    let session = URLSession(
      configuration: URLSessionConfiguration.default,
      delegate: nil,
      delegateQueue: OperationQueue.main)

    let task = session.dataTask(
      with: request,
      completionHandler: { (dataOrNil, response, error) in

        if let data = dataOrNil {
          if let responseDictonary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] {
            completion(responseDictonary as AnyObject)
          }
        }

        completion(error as AnyObject)
      }
    )

    task.resume()
  }

  public func getTopMovies(page: Int, completion: @escaping (AnyObject) -> Void) {
    let request = URLRequest(
      url: FlicksRequester.topMoviesUrl!,
      cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalCacheData,
      timeoutInterval: 10)

    let session = URLSession(
      configuration: URLSessionConfiguration.default,
      delegate: nil,
      delegateQueue: OperationQueue.main)

    let task = session.dataTask(
      with: request,
      completionHandler: { (dataOrNil, response, error) in

        if let data = dataOrNil {
          if let responseDictonary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] {
            completion(responseDictonary as AnyObject)
          }
        }

        completion(error as AnyObject)
      }
    )
    
    task.resume()
  }
}
