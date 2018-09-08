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
UICollectionViewDelegateFlowLayout, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var toggleViewSwitch: UIBarButtonItem!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var viewType: ViewType = .list {
        didSet {
            switch viewType {
            case .list:
                self.tableView.isHidden = false
                self.collectionView.isHidden = true
            case .grid:
                self.tableView.isHidden = true
                self.collectionView.isHidden = false
            }
        }
    }
    
    
    var moviesType = MoviesType.popular  //Defaults to popular movies
   // var planet: Planet
    var moviesList: [Movie] = []
    var nextPageToLoad: Int? = 0
    
    var filteredMoviesList =  [Movie]() {
        didSet {
            collectionView.reloadData()
            tableView.reloadData()
        }
    }
    
    
    //Mark -Searchbar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    print("SearchBar button text set with empty text \(searchText.isEmpty)")
        filteredMoviesList =  searchText.isEmpty ? moviesList : moviesList.filter { (movie) -> Bool in
            return   movie.title!.range(of: searchText , options: .caseInsensitive) != nil
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        //TODO investigate why this not triggering the textDidChange listener, For now
        filteredMoviesList = moviesList
        searchBar.resignFirstResponder()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        // Do any additional setup after loading the view.
        print("In ListViewController: " + moviesType.rawValue)
        loadMovies()
        setUpCollectionView()
        setUpTableView()
        setUpViews()
    }
    
    func setUpViews() {
        searchBar.delegate = self
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
        if let nextPageToLoad = nextPageToLoad {
            MoviesAPIService.getMoviesList(moviesType: moviesType.rawValue , pageNumber: nextPageToLoad) { (moviesApiResult) in
                if let moviesApiResult = moviesApiResult {
                    self.nextPageToLoad = moviesApiResult.nextPage
                    self.moviesList.append(contentsOf: moviesApiResult.moviesList)
                    self.filteredMoviesList = self.moviesList
                } else{
                    print("Error getting movies ")
                }
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

    
    
    @IBAction func togleViewTypeClicked(_ sender: Any) {
        toggleNavBarViewTypeItem()
    }
    
    func toggleNavBarViewTypeItem(){
        switch viewType {
        case .grid:
            toggleViewSwitch.title = "Grid"
            viewType = .list
        case.list:
            toggleViewSwitch.title = "List"
            viewType = .grid
        }
    }
    
    
    
    
    
    //Mark: - Collectionview and TableView methods methods
    
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentMovie = filteredMoviesList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridViewCell", for: indexPath) as! MovieGridViewCell
        cell.populateViews(movie: currentMovie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredMoviesList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMoviesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentMovie = filteredMoviesList [indexPath.row]
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
