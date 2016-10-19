//
//  FlicksMovie.swift
//  flicks
//
//  Created by Alex Liu on 10/18/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import Foundation
import ObjectMapper

class FlicksMovie: Mappable {

  var isAdult: Bool?
  var backdropPath: String?
  var genreIds: [Int]?
  var id: Int?
  var originalLanguage: String?
  var originalTitle: String?
  var overview: String?
  var popularity: Double?
  var posterPath: String?
  var title: String?
  var isVideo: Bool?
  var voteAverage: Double?
  var voteCount: Double?

  required init?(map: Map) {

  }

  func mapping(map: Map) {
    isAdult           <- map["adult"]
    backdropPath      <- map["backdrop_path"]
    genreIds          <- map["genre_ids"]
    id                <- map["id"]
    originalLanguage  <- map["original_language"]
    originalTitle     <- map["original_title"]
    overview          <- map["overview"]
    popularity        <- map["popularity"]
    posterPath        <- map["poster_path"]
    title             <- map["title"]
    isVideo           <- map["video"]
    voteAverage       <- map["vote_average"]
    voteCount         <- map["vote_count"]
  }
}
