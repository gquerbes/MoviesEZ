//
//  MovieClass.swift
//  MoviesEZ
//
//  Created by Gabriel Querbes on 12/3/15.
//  Copyright © 2015 The Modern Tech. All rights reserved.
//

import Foundation


class MovieClass{
    
    var title: String = ""
    var posterURL: String = ""
    var description: String = ""
    var releaseDate: String = ""
    var rating: Int = -9
    let URL_BASE = "http://image.tmdb.org/t/p/w500"
    
    
    
    init(title:String, posterURL: String, description:String,releaseDate:String,rating:Int){
        self.title = title
        self.description = description
        self.posterURL = "\(URL_BASE)\(posterURL)"
        self.rating = rating
        self.releaseDate = releaseDate
    
    }
    
}