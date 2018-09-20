//
//  MovieGridViewCell.swift
//  Movies Info
//
//  Created by Rasheed Sulayman on 29/07/2018.
//  Copyright © 2018 r4sh33d. All rights reserved.
//

import UIKit

class MovieGridViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var yearLabel: UILabel?
    @IBOutlet weak var ratingsLabel: UILabel?
    
    
    func populateViews(movie: Movie) {
        if let posterPath = movie.posterImageUrl() {
            let url = URL(string:posterPath)!
            posterImageView.af_setImage(withURL: url)
        }
        yearLabel?.text = movie.relaseYear()
        ratingsLabel?.text = String(format: " %.2f ", movie.voteAverage!)
    }
    
}
