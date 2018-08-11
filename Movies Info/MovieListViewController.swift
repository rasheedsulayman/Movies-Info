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
UICollectionViewDelegateFlowLayout, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    var moviesType = MoviesType.popular //Defaults to popular movies
   // var planet: Planet
    var moviesList: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        // Do any additional setup after loading the view.
        print("In ListViewController: " + moviesType.rawValue)
        loadMovies()
        setUpCollectionView()
    }

    func setUpCollectionView() {
    collectionView.dataSource = self
    collectionView.delegate = self
    let columnLayout = ColumnFlowLayout(
    cellsPerRow: 2,
    minimumInteritemSpacing: 10,
    minimumLineSpacing: 10,
    sectionInset: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    collectionView.collectionViewLayout = columnLayout
        collectionView?.contentInsetAdjustmentBehavior = .always
    }
    
    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
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
    
   
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    
    //Mark: - Collectionview and TableView methods methods
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentMovie = moviesList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridViewCell", for: indexPath)
            as! MovieGridViewCell
        cell.populateViews(movie: currentMovie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentMovie = moviesList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListViewCell", for: indexPath)
            as! MovieListViewCell
        cell.populateViews(movie: currentMovie)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    enum ViewType {
        case list
        case grid
    }
}
