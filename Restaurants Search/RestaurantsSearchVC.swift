//
//  RestaurantsSearchVC.swift
//  Restaurants Search
//
//  Created by Harshal Pathak on 25/06/21.
//

import UIKit
import SVProgressHUD

class RestaurantsSearchVC: UIViewController {

    //MARK:- Outlets For change distance and display it in label
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var sliderDistance: UISlider!
    @IBOutlet weak var tblRestaurants: UITableView!
    var offset = 0
    var distanceValue = 0
    
    var isMoreDataLoading = false
    var loadingMoreView:InfiniteScrollActivityView?
    
    private var refreshControl = UIRefreshControl()
    
    //MARK:- Call API as long as distance value is set
    var isForFirstTime = true
    var distanceRange: Int = 500 {
        didSet {
            self.showLoaderWithLabel()
            GetRestaurantsViewModel().getRestuarants(withinRange: distanceRange, withOffset: offset) { result in
                SVProgressHUD.dismiss()
                self.mainResponse = result
                if let businesses = result.restaurantsResults.businesses {
                    self.restaurantResult.addResult(isForFirstTime: self.isForFirstTime, results: businesses)
                    DispatchQueue.main.async {
                        self.tblRestaurants.reloadData()
                    }
                    
                }
            }
        }
    }
    
    var restaurantResult: RestaurantsListResultsViewModel = RestaurantsListResultsViewModel()
    var mainResponse: RestaurantsResultsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialValues()
    }
    
    func initialValues() {
        sliderDistance.minimumValue = 100
        sliderDistance.value = 500
        sliderDistance.maximumValue = 5000
        
        // Set up infinite scroll loading indicator to table view
        let frame = CGRect(x: 0, y: tblRestaurants.contentSize.height, width: tblRestaurants.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
        loadingMoreView = InfiniteScrollActivityView(frame: frame)
        loadingMoreView!.isHidden = true
        tblRestaurants.addSubview(loadingMoreView!)
        
        var insets = tblRestaurants.contentInset
        insets.bottom += InfiniteScrollActivityView.defaultHeight
        tblRestaurants.contentInset = insets
        
        // Load the table with initial data
        distanceRange = 500
        
        tblRestaurants.delegate = self
        tblRestaurants.dataSource = self
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tblRestaurants.refreshControl = refreshControl
        } else {
            tblRestaurants.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
    }
    
    @objc private func refreshWeatherData(_ sender: Any) {
        // Fetch Weather Data
        isForFirstTime = true
        offset = 0
        
        GetRestaurantsViewModel().getRestuarants(withinRange: distanceValue, withOffset: offset) { result in
            self.mainResponse = result
            if let businesses = result.restaurantsResults.businesses {
                self.restaurantResult.addResult(isForFirstTime: self.isForFirstTime, results: businesses)
                DispatchQueue.main.async {
                    self.tblRestaurants.reloadData()
                    self.refreshControl.endRefreshing()
                }
                
            }
        }
    }
    
    @IBAction func onDistanceChange(_ sender: UISlider) {
        distanceValue = Int(sender.value.rounded())
        let valueInDistance = Double(distanceValue) / Double(1000)
        
        isForFirstTime = true
        offset = 0
        
        distanceRange = distanceValue
        
        if distanceValue < 1000 {
            lblDistance.text = "\(distanceValue) M"
        } else {
            lblDistance.text = "\(valueInDistance.getDispalyValue()) KM"
        }
    }
    
    func loadMore() {
        guard let totalCount = mainResponse?.totalCount else { return }
        if offset < totalCount {
            //Updating Offset for next load
            isForFirstTime = false
            GetRestaurantsViewModel().getRestuarants(withinRange: distanceRange, withOffset: offset) { result in
                self.mainResponse = result
                if let businesses = result.restaurantsResults.businesses {
                    self.restaurantResult.addResult(isForFirstTime: self.isForFirstTime, results: businesses)
                    DispatchQueue.main.async {
                        self.tblRestaurants.reloadData()
                        self.offset = self.restaurantResult.numberOfRows(0)
                        // Stop the loading indicator
                        self.loadingMoreView!.stopAnimating()
                        // Update flag
                        self.isMoreDataLoading = false
                    }
                    
                }
            }
        } else {
            // Avoid extra space at bottom of tableview after infinite scroll has reached end of list.
            var insets = tblRestaurants.contentInset
            insets.bottom = 0.0
            tblRestaurants.contentInset = insets
            
            // Update flag
            self.isMoreDataLoading = false
            
            // Stop the loading indicator
            self.loadingMoreView!.stopAnimating()
        }
    }
}

extension RestaurantsSearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.restaurantResult.numberOfRows(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellRestaurants", for: indexPath) as! RestaurantTVC
        print("\(indexPath.row+1)")
        let business = self.restaurantResult.modelAt(indexPath.row)
        cell.setData(withObject: business)
        return cell
    }
}

extension RestaurantsSearchVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = tblRestaurants.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tblRestaurants.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tblRestaurants.isDragging) {
                isMoreDataLoading = true
                
                // Update position of loadingMoreView, and start loading indicator
                let frame = CGRect(x: 0, y: tblRestaurants.contentSize.height, width: tblRestaurants.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
                loadingMoreView?.frame = frame
                loadingMoreView!.startAnimating()
                
                // load more data
                loadMore()
                
            }
        }
    }
}
