//
//  AddCoffeeOrderViewModel.swift
//  Moon Bucks
//
//  Created by Michael Grant on 12/10/19.
//  Copyright © 2019 Michael Grant. All rights reserved.
//

import Foundation

struct AddCoffeeOrderViewModel {
    
    var name: String?
    var email: String?
    var selectedType: String?
    var selectdSize: String?
    
    var types: [String] {
        
        return CoffeeType.allCases.map { $0.rawValue.capitalized }
        
    }
    
    var sizes: [String] {
        
        return CoffeeSize.allCases.map { $0.rawValue.capitalized }
        
    }
    
}
