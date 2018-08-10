//
//  Constants.swift
//  Movies Info
//
//  Created by Rasheed Sulayman on 28/07/2018.
//  Copyright © 2018 r4sh33d. All rights reserved.
//

import Foundation

struct Constants {
    static let API_KEY = "5018815e8ba8370cd1ca9f94183aba1a"
    static let BASE_URL = "https://api.themoviedb.org/3/movie/"
    static let MOVIE_SEARCH_BASE_URL = "https://api.themoviedb.org/3/search/movie"
    static let IMAGES_BASE_URL = "https://image.tmdb.org/t/p/"
    static let BACK_DROP_BASE_URL = IMAGES_BASE_URL + "/w500"
    static let POSTER_BASE_URL = IMAGES_BASE_URL + "/w185"
    static let KEY_POPULAR = "popular"
    static let KEY_UPCOMING = "upcoming"
    static let KEY_TOP_RATED = "top_rated"
    
    
//    //https://apiv2.bitcoinaverage.com/indices/global/ticker/BTCBRL
//    The Url: https://apiv2.bitcoinaverage.com/indices/global/ticker/BTCBRL
//    ------------------------------------------
//    The original request: Optional(https://apiv2.bitcoinaverage.com/indices/global/ticker/BTCBRL)
//    ------------------------------------------
//    The response response: Optional(<NSHTTPURLResponse: 0x604000424d80> { URL: https://apiv2.bitcoinaverage.com/indices/global/ticker/BTCBRL } { Status Code: 200, Headers {
//    "Access-Control-Allow-Origin" =     (
//    "*"
//    );
//    Connection =     (
//    "keep-alive"
//    );
//    "Content-Encoding" =     (
//    gzip
//    );
//    "Content-Type" =     (
//    "application/json; charset=UTF-8"
//    );
//    Date =     (
//    "Thu, 09 Aug 2018 23:38:24 GMT"
//    );
//    Etag =     (
//    "W/\"4b5b3c0279a2c6a1b41a16b3eac5ab5e71c54b57\""
//    );
//    Server =     (
//    "nginx/1.10.3 (Ubuntu)"
//    );
//    "Transfer-Encoding" =     (
//    Identity
//    );
//    Vary =     (
//    "Accept-Encoding"
//    );
//    "X-Cache-Status" =     (
//    EXPIRED
//    );
//    } })
//    ------------------------------------------
//    The response result: SUCCESS
//    ------------------------------------------
//    The response value: Optional({
//    ask = "24931.02";
//    averages =     {
//    day = "24297.92";
//    month = "25528.28";
//    week = "25482.33";
//    };
//    bid = "24921.73";
//    changes =     {
//    percent =         {
//    day = "4.24";
//    hour = "-0.8100000000000001";
//    month = "-2.51";
//    "month_3" = "-28.8";
//    "month_6" = "-20.82";
//    week = "-14.25";
//    year = "95.04000000000001";
//    };
//    price =         {
//    day = "1012.01";
//    hour = "-204.19";
//    month = "-641.14";
//    "month_3" = "-10066.84";
//    "month_6" = "-6547.06";
//    week = "-4137.5";
//    year = "12129.61";
//    };
//    };
//    "display_timestamp" = "2018-08-09 23:38:23";
//    high = "25183.77";
//    last = "24892.45";
//    low = "23567.57";
//    open =     {
//    day = "23880.44";
//    hour = "25096.64";
//    month = "25533.58";
//    "month_3" = "34959.29";
//    "month_6" = "31439.51";
//    week = "29029.95";
//    year = "12762.84";
//    };
//    timestamp = 1533857903;
//    volume = "95574.81352862";
//    "volume_percent" = "0.68";
//    })
//    ------------------------------------------
}
