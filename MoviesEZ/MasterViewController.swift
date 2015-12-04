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
    
    func createMovies()->[MovieClass]{
        var moviesArray = [MovieClass]()
        
        //URL of JSON DATA
        let dataURL: NSURL = NSURL(string:"http://api.themoviedb.org/3/movie/popular?api_key=ff743742b3b6c89feb59dfc138b4c12f")!
        
        
    
        
        let jsonURLData = NSData(contentsOfURL:dataURL)
        
        if(jsonURLData != nil){
            
            let aDictionary: NSDictionary =
            //NSJSONSerialization converts NSData from one type to another
            (try! NSJSONSerialization.JSONObjectWithData(jsonURLData!, options: NSJSONReadingOptions.MutableContainers))as! NSDictionary
            print("wtf")
            print(aDictionary)
            
        }
        else {
          print("fuck")  
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

    func insertNewObject(sender: AnyObject) {
        objects.insert(NSDate(), atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }

    
    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row] as! NSDate
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
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
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let object = objects[indexPath.row] as! NSDate
        cell.textLabel!.text = object.description
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
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

