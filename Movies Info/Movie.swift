//
//  Movie.swift
//  Movies Info
//
//  Created by Rasheed Sulayman on 09/08/2018.
//  Copyright © 2018 r4sh33d. All rights reserved.
//

import Foundation

struct Movie {
    var title: String?
    var overview: String?
    var posterPath: String?
    var backdropPath: String?
    var voteAverage: Double?
    var releaseDate: String? //date format pattern = " "2018-01-17"
    var id: Int?
    var tagline: String?
    var runtime: String?
    
    var duration: String? {
        get{
            if let runtime = runtime {
                return "\(runtime) mins"
            }
            return nil
        }
    }

    init(movieJsonDict : [String : Any]?) {
        if let movieJsonDict = movieJsonDict {
            title =  movieJsonDict["title"] as? String
            id =  movieJsonDict["id"] as? Int
            overview =  movieJsonDict["overview"] as? String
            posterPath =  movieJsonDict["poster_path"] as? String
            backdropPath =  movieJsonDict["backdrop_path"] as? String
            voteAverage =  movieJsonDict["vote_average"] as? Double
            releaseDate = movieJsonDict["release_date"] as? String
            tagline = movieJsonDict["tagline"] as? String
            runtime = movieJsonDict["runtime"] as? String
        }
    }
    
    //TODO convert this to a computed variable when internet is restored
    func relaseYear() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyy-MM-dd"
        if let releaseDate = releaseDate , let dateFromString = dateFormatter.date(from: releaseDate) {
            //get only the year component
            dateFormatter.dateFormat = "yyy"
            return dateFormatter.string(from: dateFromString)
        }
        return nil
    }
    
     func posterImageUrl() -> String? {
        if let posterPath = posterPath {
            return "\(Constants.POSTER_BASE_URL)\(posterPath)"
        }
        return nil
    }
    
     func backDropImageUrl() -> String? {
        if let backdropPath = backdropPath {
            return "\(Constants.BACK_DROP_BASE_URL)\(backdropPath)"
        }
        return nil
    }
}
