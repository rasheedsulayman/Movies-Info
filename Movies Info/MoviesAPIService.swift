//
//  MoviesAPIService.swift
//  Movies Info
//
//  Created by Rasheed Sulayman on 09/08/2018.
//  Copyright © 2018 r4sh33d. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MoviesAPIService {
    
    class func getMoviesList (moviesType : String, completion: @escaping ([Movie]?) -> Void) {
        let moviesURL = getMoviesListURL(moviesType: moviesType)
        Alamofire.request(moviesURL).responseJSON { response in
            var moviesList: [Movie] = []
            debugPrint(response)
            if response.result.isSuccess {
                let json = JSON(response.result.value!)
                if let moviesJsonList = json["results"].array {
                    for movie in moviesJsonList {
                        moviesList.append(Movie(movieJsonDict: movie.dictionaryObject))
                    }
                }
                completion(moviesList)
            } else {
                completion(nil)
            }
        }
    }
    
    
    class func getPosterImageUrl(imagePath: String) -> String {
        return "\(Constants.POSTER_BASE_URL)\(imagePath)"
    }
    
    class func getBackDropImageUrl(imagePath: String) -> String {
        return "\(Constants.BACK_DROP_BASE_URL)\(imagePath)"
    }
    
    class func getMoviesListURL(moviesType: String) -> String {
        return appendAPIKeyToURL(url:"\(Constants.BASE_URL)\(moviesType)")
    }
    
    class func appendAPIKeyToURL(url: String) -> String {
        return "\(url)?api_key=\(Constants.API_KEY)"
    }
}

enum MoviesType: String {
    case popular = "popular"
    case upcoming = "upcoming"
    case nowPlaying = "now_playing"
    case topRated = "top_rated"
}









