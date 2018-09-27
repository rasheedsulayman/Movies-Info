//
//  MovieDetailsViewController.swift
//  Movies Info
//
//  Created by Rasheed Sulayman on 20/09/2018.
//  Copyright © 2018 r4sh33d. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController ,
UICollectionViewDataSource , UICollectionViewDelegate {
  
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var ratingsLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieSummaryLabel: UILabel!
    @IBOutlet weak var similarMoviesCollectionView: UICollectionView!
    @IBOutlet weak var viewTrailerButton: UIButton!
    
    var movie: Movie!
    var similarMoviesList: [Movie] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateViews()
        setUpCollectionView()
        loadSimilarMovies()
        loadMoreDetailedMovie()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setUpCollectionView() {
        similarMoviesCollectionView.dataSource = self
        similarMoviesCollectionView.delegate = self
    }
    
    
    func populateViews(){
        title = movie.title
        if let backDropPath = movie.backDropImageUrl() {
            let url = URL(string:backDropPath)!
            backdropImageView.af_setImage(
                withURL: url,
                placeholderImage: UIImage(named: "movie100brown")!,
                imageTransition: .crossDissolve(0.2)
            )
        }
        if let posterPath = movie.posterImageUrl() {
            let url = URL(string:posterPath)!
            posterImageView.af_setImage(withURL: url,imageTransition: .crossDissolve(0.2) )
        }
        titleLabel.text = movie.title
        taglineLabel.text = movie.tagline
        ratingsLabel.text = String(format: " %.2f ", movie.voteAverage!)
        durationLabel.text = movie.duration
        genresLabel.text = movie.genres
        movieSummaryLabel.text = movie.overview
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similarMoviesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentMovie = similarMoviesList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridViewCell", for: indexPath) as! MovieGridViewCell
        cell.populateViews(movie: currentMovie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
        detailController.movie = self.similarMoviesList[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    func loadSimilarMovies () {
        MoviesAPIService.getSimilarMovies(movieId: movie.id!) { (moviesList) in
            if let moviesList = moviesList {
                print("Similar movies gotten and the length is \(moviesList.count)")
                self.similarMoviesList.append(contentsOf: moviesList)
                self.similarMoviesCollectionView.reloadData()
            }else{
                print("Error in getting similar movies")
                //Hide the collection view
                //Error happened
            }
        }
    }
    
    func loadMoreDetailedMovie(){
        MoviesAPIService.getMoreDetailedMovie(movieId: movie.id!) { (movie) in
            if let movie = movie {
                self.movie = movie
                self.populateViews()
                self.viewTrailerButton.isEnabled = true
                self.viewTrailerButton.isHidden = false
            }else{
                //Fail silently
                //Could not get the trailer key
                //Hide the View trailers button
                
            }
        }
    }
    
    
    @IBAction func onViewTrailerButtonClicked(_ sender: Any) {
        if let trailerKey = movie.trailerKey {
            var url = URL(string:"youtube://\(trailerKey)")!
            if !UIApplication.shared.canOpenURL(url)  {
                url = URL(string:"http://www.youtube.com/watch?v=\(trailerKey)")!
            }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
