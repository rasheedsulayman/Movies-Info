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
    
    
    class func getMoviesList (moviesType : String, completion: ([Movie])) {
        let moviesURL = Constants.BASE_URL + moviesType
        Alamofire.request(moviesURL).responseJSON { response in
            debugPrint(response)
            
            if response.result.isSuccess {
                let json = JSON(response.result.value!)
                
                print("JSON: \(json)")
            }
        }
    }
    
   
}
