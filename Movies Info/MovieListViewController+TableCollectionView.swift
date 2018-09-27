//
//  MovieListViewController+TableAndCollectionViewCallBacks.swift
//  Movies Info
//
//  Created by Rasheed Sulayman on 09/09/2018.
//  Copyright © 2018 r4sh33d. All rights reserved.
//

import Foundation
import UIKit


extension MovieListViewController: UICollectionViewDelegate , UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout, UITableViewDataSource, UITableViewDelegate {
    
    //Mark: - Collectionview and TableView methods methods
    
    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        //FooterActivity indicator for tableView
        //Place the new view to the buttom/end of the tableview content
        let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
        tableViewLoadingMoreView = InfiniteScrollActivityView(frame: frame)
        tableViewLoadingMoreView!.isHidden = true
        tableView.addSubview(tableViewLoadingMoreView!)
        //Shift The tableView content up by LoadingMoreView height to make the indicator visible.
        var insets = tableView.contentInset
        insets.bottom += InfiniteScrollActivityView.defaultHeight
        tableView.contentInset = insets
        
    
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
        //Footer Activity indicator for collectionView
        let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
        collectionViewLoadingMoreView = InfiniteScrollActivityView(frame: frame)
        collectionViewLoadingMoreView!.isHidden = true
        collectionView.addSubview(collectionViewLoadingMoreView!)
        var insets = collectionView.contentInset
        insets.bottom += InfiniteScrollActivityView.defaultHeight
        collectionView.contentInset = insets
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (!isDataLoading && !isFirstLoad()) {
            if !tableView.isHidden {
                // Calculate the position of one screen length before the bottom of the results
                let scrollViewContentHeight = tableView.contentSize.height
                let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
                
                // When the user has scrolled past the threshold, start requesting
                if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging) {
                    isDataLoading = true
                    
                    // Update position of loadingMoreView, and start loading indicator
                    let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
                    tableViewLoadingMoreView?.frame = frame
                    tableViewLoadingMoreView!.startAnimating()
                    // Code to load more results
                    loadMovies()
                }
            } else {
                //CollectionView
                // Calculate the position of one screen length before the bottom of the results
                let scrollViewContentHeight = collectionView.contentSize.height
                let scrollOffsetThreshold = scrollViewContentHeight - collectionView.bounds.size.height
                
                // When the user has scrolled past the threshold, start requesting
                if(scrollView.contentOffset.y > scrollOffsetThreshold && collectionView.isDragging) {
                    isDataLoading = true
                    // Update position of loadingMoreView, and start loading indicator
                    let frame = CGRect(x: 0, y: collectionView.contentSize.height, width: collectionView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
                    collectionViewLoadingMoreView?.frame = frame
                    collectionViewLoadingMoreView!.startAnimating()
                    
                    // load more movies.
                    loadMovies()
                }
            }
        }
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
}
