//
//  MovieListViewCell.swift
//  Movies Info
//
//  Created by Rasheed Sulayman on 11/08/2018.
//  Copyright © 2018 r4sh33d. All rights reserved.
//

import UIKit

class MovieListViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var ratingsLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populateViews(movie: Movie) {
        if let posterPath = movie.posterImageUrl() {
            let url = URL(string:posterPath)!
            posterImageView.af_setImage(withURL: url)
        }
        yearLabel.text = movie.relaseYear()
        ratingsLabel.text = String(format: " %.2f ", movie.voteAverage!)
        summaryLabel.text = movie.overview
        titleLabel.text = movie.title
    }

}
