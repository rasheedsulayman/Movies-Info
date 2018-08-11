//
//  MovieListViewController.swift
//  Movies Info
//
//  Created by Rasheed Sulayman on 09/08/2018.
//  Copyright © 2018 r4sh33d. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieListViewController: UIViewController, UICollectionViewDelegate , UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    var moviesType: String!
    var moviesList: [Movie] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func prepareTabItem(){
        
    }
    
    
    
    func loadMovies(){
        MoviesAPIService.getMoviesList(moviesType: moviesType) { (movies) in
            if let movies = movies {
                self.moviesList.append(contentsOf: movies)
                self.collectionView.reloadData()
            } else{
                print("Error getting movies ")
            }
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Mark: - Collectionview methods
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentMovie = moviesList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridViewCell", for: indexPath) as! MovieGridViewCell
        cell.ratingsLabel.text = currentMovie.title
        if let posterPath = currentMovie.posterImageUrl() {
            let url = URL(string:posterPath)!
            cell.posterImageView.af_setImage(withURL: url)
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesList.count
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
