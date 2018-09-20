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
    
    func populateViews(){
        if let backDropPath = movie.backDropImageUrl() {
            let url = URL(string:backDropPath)!
            posterImageView.af_setImage(withURL: url)
        }
        titleLabel.text = movie.title!
        taglineLabel.text = movie.tagline!
        ratingsLabel.text = String(format: " %.2f ", movie.voteAverage!)
        durationLabel.text

    }
    
    var movie: Movie!
    var similarMoviesList: [Movie] = []
    var trailerKey: String! {
        didSet {
            viewTrailerButton.isEnabled = true
            viewTrailerButton.isHidden = false
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setUpCollectionView() {
        similarMoviesCollectionView.dataSource = self
        similarMoviesCollectionView.delegate = self
//        let columnLayout = ColumnFlowLayout(
//            cellsPerRow: 2,
//            minimumInteritemSpacing: 10,
//            minimumLineSpacing: 10,
//            sectionInset: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    // similarMoviesCollectionView.collectionViewLayout = columnLayout
       // similarMoviesCollectionView.contentInsetAdjustmentBehavior = .always
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
                self.similarMoviesList.append(contentsOf: moviesList)
                self.similarMoviesCollectionView.reloadData()
            }else{
                //Hide the collection view
                //Error happened
            }
        }
    }
    
    func loadTrailerKey(){
        MoviesAPIService.getMovieTrailerKey(movieId: movie.id!) { (trailerKey) in
            if let trailerKey = trailerKey {
                self.trailerKey = trailerKey
            }else{
                //Could not get the trailer key
                //Hide the View trailers button
            }
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
