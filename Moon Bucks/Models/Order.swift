//
//  Order.swift
//  Moon Bucks
//
//  Created by Michael Grant on 11/27/19.
//  Copyright © 2019 Michael Grant. All rights reserved.
//

import Foundation

enum CoffeeType: String, Codable, CaseIterable {
    
    case cappuccino
    case lattee
    case esperessino
    case cortado
}

enum CoffeeSize: String, Codable, CaseIterable {
    
    case small
    case medium
    case large
}

struct Order: Codable {
    
    let name: String
    let email: String
    let type: CoffeeType
    let size: CoffeeSize
}
