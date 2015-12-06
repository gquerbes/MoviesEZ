//
//  DetailViewController.swift
//  MoviesEZ
//
//  Created by Gabriel Querbes on 12/3/15.
//  Copyright © 2015 The Modern Tech. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblMovieDescription: UILabel!
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblReleaseDate: UILabel!

    var detailItem: MovieClass? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.releaseDate
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        
        //set title of bar to title of movie
        self.title = self.detailItem?.title
        
        //set rating
        lblRating.text = String (self.detailItem!.rating) + "/10"
        
        
        //set background color
        //self.view.backgroundColor =  UIColor(red:192/255.0, green: 192/255.0, blue: 192/255.0, alpha:1.0)
        let colors = ColorStruct()
        self.view.backgroundColor=colors.getRandomColor()
        
        //show movie description
        lblMovieDescription.text = self.detailItem?.description
        
        //set title of moive
        lblTitle.text = self.detailItem!.title
        
       
        
        //show movie poster
        if let path = self.detailItem?.posterURL{
            let url = NSURL(string: path)!
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
                
                let data = NSData(contentsOfURL: url)!
                
                dispatch_async(dispatch_get_main_queue()){
                    let img = UIImage(data:data)
                    self.imgPoster.image = img
                    //self.movieImg.image = img
                    
                }
            }
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

