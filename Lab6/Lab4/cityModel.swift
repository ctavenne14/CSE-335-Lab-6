//
//  cityModel.swift
//  Lab4
//
//  Created by Cody Tavenner on 2/18/19.
//  Copyright © 2019 Cody Tavenner. All rights reserved.
//

import Foundation
class cityModel
{
    var cities:[city] = []
    
    init()
    {
        let f1 = city(fn: "Tempe", fin: "tempe.jpeg")
        let f2 = city(fn: "Chandler", fin: "chandlet.jpeg")
        let f3 = city(fn: "Gilbert", fin: "gilbert.jpeg")
        let f4 = city(fn: "San Diego", fin: "san diego.jpeg")
        let f5 = city(fn: "Denver", fin: "denver.jpeg")

        
        cities.append(f1)
        cities.append(f2)
        cities.append(f3)
        cities.append(f4)
        cities.append(f5)

        
    }
    
}
class city
{
    var cityName:String?
    var cityImageName:String?
    
    init(fn:String, fin:String)
    {
        cityName = fn
        cityImageName = fin
        
    }
    
    
}
