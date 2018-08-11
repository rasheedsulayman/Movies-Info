//
//  ViewController.swift
//  Movies Info
//
//  Created by Rasheed Sulayman on 28/07/2018.
//  Copyright © 2018 r4sh33d. All rights reserved.
//

import UIKit

class MoviesTabBarContorller: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Create three navigation controllers to serve as the root screen controllers for this tabBarcontroller
        let upcomingNavigationController = getNavigationGenericNavigationViewController()
        let nowPlayingNavigationController  = getNavigationGenericNavigationViewController()
        let topRatedNavigationController = getNavigationGenericNavigationViewController()
        let popularNavigationController = getNavigationGenericNavigationViewController()
        
        //Try to set the moviesType for all the moviesListView controllers
        let upcomingMoviesViewController  = upcomingNavigationController.topViewController as! MovieListViewController
        let topRatedMoviesViewController  = topRatedNavigationController.topViewController as! MovieListViewController
        let nowPlayingMoviesController  = nowPlayingNavigationController.topViewController as! MovieListViewController
        let popularMoviesViewController  = popularNavigationController.topViewController as! MovieListViewController
        
        //Set Movies type to determine the types of movies to load
        upcomingMoviesViewController.moviesType =  Constants.KEY_UPCOMING
        topRatedMoviesViewController.moviesType =  Constants.KEY_TOP_RATED
        nowPlayingMoviesController.moviesType   =  Constants.KEY_NOW_PLAYING
        popularMoviesViewController.moviesType  =  Constants.KEY_POPULAR
        
        //customize tab items based on moviesType
        upcomingMoviesViewController.prepareTabItem()
        topRatedMoviesViewController.prepareTabItem()
        nowPlayingMoviesController.prepareTabItem()
        popularMoviesViewController.prepareTabItem()
        
        viewControllers = [popularNavigationController , topRatedNavigationController , nowPlayingMoviesController , upcomingMoviesViewController]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getNavigationGenericNavigationViewController() -> UINavigationController {
        let storyboard = self.storyboard!
        return storyboard.instantiateViewController(withIdentifier: "NavigationController") as! UINavigationController
    }
}

