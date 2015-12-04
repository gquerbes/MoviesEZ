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
    
    
    
    init(title:String, posterURL: String, description:String){
        self.title = title
        self.posterURL = posterURL
        self.description = description
    }
    
    
}