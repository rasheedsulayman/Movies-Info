//
//  MovieListViewController.swift
//  Movies Info
//
//  Created by Rasheed Sulayman on 09/08/2018.
//  Copyright © 2018 r4sh33d. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieListViewController: UIViewController, UICollectionViewDelegate , UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    var moviesType = MoviesType.popular //Defaults to popular movies
   // var planet: Planet
    var moviesList: [Movie] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        // Do any additional setup after loading the view.
        print("In ListViewController: " + moviesType.rawValue)
        loadMovies()
        setUpCollectionView()
        
    }

    func setUpCollectionView() {
    let columnLayout = ColumnFlowLayout(
    cellsPerRow: 2,
    minimumInteritemSpacing: 10,
    minimumLineSpacing: 10,
    sectionInset: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    collectionView.collectionViewLayout = columnLayout
        collectionView?.contentInsetAdjustmentBehavior = .always
    }
    
    func prepareTabItem () {
        let tabItem = navigationController!.tabBarItem!
        switch moviesType {
        case .nowPlaying:
            title = "Now Playing"
            tabItem.title = "Now Playing"
        case .popular:
            title = "Popular"
            tabItem.title = "Popular"
        case .topRated:
            title = "Top rated"
            tabItem.title = "Top Rated"
        case .upcoming:
            title  = "Upcoming"
            tabItem.title = "Upcoming"
        }
    }
    
    
    func loadMovies(){
        MoviesAPIService.getMoviesList(moviesType: moviesType.rawValue) { (movies) in
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
    
    // MARK: UICollectionViewDelegateFlowLayout methods
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentMovie = moviesList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridViewCell", for: indexPath)
            as! MovieGridViewCell
        if let posterPath = currentMovie.posterImageUrl() {
            let url = URL(string:posterPath)!
            cell.posterImageView.af_setImage(withURL: url)
        }
        cell.ratingsLabel.text = String(format: "%.2f", currentMovie.voteAverage!)
        
        
        
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
    
    enum ViewType {
        case list
        case grid
    }
}
