//
//  MovieListViewController.swift
//  Movies Info
//
//  Created by Rasheed Sulayman on 09/08/2018.
//  Copyright © 2018 r4sh33d. All rights reserved.
//

import UIKit
import AlamofireImage
import MBProgressHUD

class MovieListViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var toggleViewSwitch: UIBarButtonItem!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var connectionErrorView: UIView!
    
    var isDataLoading = false
    var tableViewLoadingMoreView:InfiniteScrollActivityView?
    var collectionViewLoadingMoreView:InfiniteScrollActivityView?
    var loadingNotification: MBProgressHUD?

    
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
    var moviesList: [Movie] = []
    var nextPageToLoad: Int? = 1
    
    var filteredMoviesList =  [Movie]() {
        didSet {
            collectionView.reloadData()
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpCollectionView()
        setUpTableView()
        setUpViews()
        loadMovies()
        connectionErrorView.layer.zPosition = 1
    }
    
    func setUpViews() {
        searchBar.delegate = self
        searchBar.barStyle = .blackTranslucent
    }
    
    func prepareTabItem () {
        let tabItem = navigationController!.tabBarItem!
        
        switch moviesType {
        case .nowPlaying:
            title = "Now Playing"
            tabItem.title = title
            tabItem.image = UIImage(named: "nowplaying")
        case .popular:
            title = "Popular"
            tabItem.title = title
            tabItem.image = UIImage(named: "popular")
        case .topRated:
            title = "Top Rated"
            tabItem.title = title
            tabItem.image = UIImage(named: "topratedicon")
        case .upcoming:
            title  = "Upcoming"
            tabItem.title = title
            tabItem.image = UIImage(named: "upcoming")
        }
    }
    
    func isFirstLoad() -> Bool {
        if let nextPageToLoad = nextPageToLoad {
            return nextPageToLoad == 1
        }
        return false
    }
    
    func showLoadingIndicator()  {
        loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
        loadingNotification!.mode = MBProgressHUDMode.indeterminate
        loadingNotification!.isUserInteractionEnabled = false
        loadingNotification!.label.text = "Loading Movies"
    }
    
    func showErrorLabel() {
        connectionErrorView.isHidden = false
        connectionErrorView.layer.zPosition = 1
    }
    
    func dismissErrorLabel() {
        connectionErrorView.isHidden = true
        connectionErrorView.layer.zPosition = 0
    }
    
    func stopLoadingMoreViewAnimation()  {
        self.tableViewLoadingMoreView!.stopAnimating()
        self.collectionViewLoadingMoreView!.stopAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func togleViewTypeClicked(_ sender: Any) {
        toggleNavBarViewTypeItem()
    }
    
    func toggleNavBarViewTypeItem(){
        switch viewType {
        case .grid:
            toggleViewSwitch.image = UIImage(named:"grid")
            //toggleViewSwitch.title = "Grid"
            viewType = .list
        case.list:
            toggleViewSwitch.image = UIImage(named:"list")
           // toggleViewSwitch.title = "List"
            viewType = .grid
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigateToDetailsViewController(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToDetailsViewController(indexPath: indexPath)
    }
    
    func navigateToDetailsViewController (indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
        detailController.movie = self.filteredMoviesList[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
 
    // MARK: - Searchbar delegates implementation
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
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
    
    
    //Mark:- Networking
    func loadMovies(){
        if isFirstLoad(){
            showLoadingIndicator()
        }else{
            //We are using Activity indicator, instead of ProgressHUD, to show progress on subsequent loads.
            loadingNotification = nil
        }
        if let nextPageToLoad = nextPageToLoad {
            dismissErrorLabel()
            MoviesAPIService.getMoviesList(moviesType: moviesType.rawValue , pageNumber: nextPageToLoad) { (moviesApiResult) in
                self.loadingNotification?.hide(animated: true)
                //Update ongoingLoading flag
                self.isDataLoading = false
                self.stopLoadingMoreViewAnimation()
                if let moviesApiResult = moviesApiResult {
                    self.nextPageToLoad = moviesApiResult.nextPage
                    self.moviesList.append(contentsOf: moviesApiResult.moviesList)
                    self.filteredMoviesList = self.moviesList
                } else{
                    self.showErrorLabel()
                    print("Error getting movies ")
                }
            }
        }
    }
    
    enum ViewType {
        case list
        case grid
    }
    
}
