//
//  Movie.swift
//  Movies Info
//
//  Created by Rasheed Sulayman on 09/08/2018.
//  Copyright © 2018 r4sh33d. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Movie {
    var title: String?
    var overview: String?
    var posterPath: String?
    var backdropPath: String?
    var voteAverage: Double?
    var releaseDate: String? //date format pattern = " "2018-01-17"
    var id: Int?
    var tagline: String?
    var runtime: Int?
    var genres: String?
    var trailerKey: String?
    
    var duration: String? {
        get{
            if let runtime = runtime {
                return "\(runtime) mins"
            }
            return nil
        }
    }
    
    init(movieJson: JSON) {
        if let movieJsonDict = movieJson.dictionaryObject {
            title =  movieJsonDict["title"] as? String
            id =  movieJsonDict["id"] as? Int
            overview =  movieJsonDict["overview"] as? String
            posterPath =  movieJsonDict["poster_path"] as? String
            backdropPath =  movieJsonDict["backdrop_path"] as? String
            voteAverage =  movieJsonDict["vote_average"] as? Double
            releaseDate = movieJsonDict["release_date"] as? String
            tagline = movieJsonDict["tagline"] as? String
            runtime = movieJsonDict["runtime"] as? Int
            if let genresList = movieJsonDict["genres"] as? [[String: Any]]{
                genres = self.buildGenresList(genresList: genresList)
            }
        }
        //Trying to get youtube link
        if let resultsList = movieJson.dictionary?["videos"]?
            .dictionary?["results"]?.array {
            if resultsList.count > 0,  let trailerKey = resultsList[0].dictionary?["key"]?.string{
                self.trailerKey = trailerKey
            }
        }
    }
    
    
    
    func buildGenresList(genresList: [[String: Any]]) -> String {
        var  genresToReturn = ""
        for genres in genresList {
            if let name =  genres["name"]{
                genresToReturn.append(contentsOf: " \(name)")
            }
        }
        return genresToReturn
    }
    
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
