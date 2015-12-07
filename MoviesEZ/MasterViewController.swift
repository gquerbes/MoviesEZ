//
//  MasterViewController.swift
//  MoviesEZ
//
//  Created by Gabriel Querbes on 12/3/15.
//  Copyright © 2015 The Modern Tech. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [AnyObject]()
    
    //array of movies
    var MovieObjectArray = [MovieClass]()
    
    //function to create moives from JSON data
    func createMovies()->[MovieClass]{
        var moviesArray = [MovieClass]()
        
        //URL of JSON DATA
        let dataURL: NSURL = NSURL(string:"http://api.themoviedb.org/3/movie/popular?api_key=ff743742b3b6c89feb59dfc138b4c12f")!
        
        // JSON data set to NSData
        let jsonURLData = NSData(contentsOfURL:dataURL)
        
        
        if(jsonURLData != nil){
            
            let aDictionary: NSDictionary =
            //NSJSONSerialization converts NSData from one type to another
            (try! NSJSONSerialization.JSONObjectWithData(jsonURLData!, options: NSJSONReadingOptions.MutableContainers))as! NSDictionary
            
            print(aDictionary)
            
            //grab JSON data of all Movies
            let movieList = aDictionary["results"]as![[String:AnyObject]]
            
            
            //loop through all items in list
            
            for index in 1...movieList.count{
                
                var singleMovie = movieList[index - 1]
                
                //pull data from single movie and set to individual variables
                let mTitle = singleMovie["title"]! as? String
                let mDesritpion = singleMovie["overview"]! as? String
                let mPosterPath = singleMovie["poster_path"]! as? String
                let mReleaseDate = singleMovie["release_date"]! as? String
                let mRating = singleMovie["vote_average"]! as? Double
                
                // initialize new movie
                let mov1 = MovieClass(title: mTitle!, posterURL: mPosterPath!, description: mDesritpion!,releaseDate: mReleaseDate!, rating: mRating!)
                
                //append to array
                moviesArray.append(mov1)
                
            }
    
            
        }
        
        return moviesArray
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MovieObjectArray =  createMovies()
        
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    func insertNewObject(sender: AnyObject) {
//        objects.insert(NSDate(), atIndex: 0)
//        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
//        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
//    }

    
    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let selectedMovie = MovieObjectArray[indexPath.row] as MovieClass
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = selectedMovie
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieObjectArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let object = MovieObjectArray[indexPath.row] as MovieClass
        //main label will show name of movie
        cell.textLabel!.text = object.title
        
        //detail label will show address. cast to int to remove decimal.
        cell.detailTextLabel!.text = "Avg Rating: \(String (Int (object.rating)))/10"
       
        
        //set image on the table view
 
        let url = NSURL(string: object.posterURL)!
            
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
                
            let data = NSData(contentsOfURL: url)!
            
            dispatch_async(dispatch_get_main_queue()){
                let img = UIImage(data:data)
                 
                cell.imageView?.image = img
                }
            
            }
        return cell
        
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

