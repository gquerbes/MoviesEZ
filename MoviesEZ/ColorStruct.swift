//
//  colorStruct.swift
//  QuotesEZ
//
//  Created by Gabriel Querbes on 10/6/15.
//  Copyright © 2015 The Modern Tech. All rights reserved.
//

import Foundation
import UIKit
//start of ColorStruct
struct ColorStruct{
    //ColorArray is an array of different colors, each with their own values for RGB and alpha
    let colorArray = [
        UIColor(red:245/255.0, green: 241/255.0, blue: 234/255.0, alpha:1.0),
        UIColor(red:237/255.0, green: 224/255.0, blue: 249/255.0, alpha:1.0),
        UIColor(red:234/255.0, green: 239/255.0, blue: 201/255.0, alpha:1.0),
        UIColor(red:187/255.0, green: 239/255.0, blue: 249/255.0, alpha:1.0),
    ]
    
    
    //function to get return one of the above generated colors
    func getRandomColor() ->UIColor{
        let randomNumber = Int(arc4random_uniform(UInt32(colorArray.count)))
        return colorArray[randomNumber]
    }
    
    
}

