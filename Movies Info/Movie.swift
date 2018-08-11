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
    var releaseDate: String? //  date format pattern = " "2018-01-17"
   
    
    
//    var releaseYear {
//
//    }
//
    
    init(movieJsonDict : [String : Any]?) {
        if let movieJsonDict = movieJsonDict {
            if let title =  movieJsonDict["title"] as? String{
                self.title = title
            }
            if let overview =  movieJsonDict["overview"] as? String{
                self.overview = overview
            }
            
            if let posterPath =  movieJsonDict["poster_path"] as? String{
                self.posterPath = posterPath
            }
            if let backdropPath =  movieJsonDict["backdrop_path"] as? String{
                self.backdropPath = backdropPath
            }
            if let voteAverage =  movieJsonDict["vote_average"] as? Double{
                self.voteAverage = voteAverage
            }
            if let releaseDate = movieJsonDict["release_date"] as? String {
                self.releaseDate = releaseDate
            }
        }
    }
    
    //TODO convert this to a computed variable when internet is back
    func relaseYear() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyy/MM/dd"
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
