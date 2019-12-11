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

extension Order {
    
    static var all: Resource<[Order]> = {
        
        
        guard let url = URL(string: "https://guarded-retreat-82533.herokuapp.com/orders") else {
            fatalError("URL is incorrect")
            
        }
        
        return Resource<[Order]>(url: url)
        
    }()
    
    
    static func create(vm: AddCoffeeOrderViewModel) -> Resource<Order?> {
        
        let order = Order(vm)
        guard let url = URL(string: "https://guarded-retreat-82533.herokuapp.com/orders") else {
            fatalError("URL is incorrect")
            
        }
        
        guard let data = try? JSONEncoder().encode(order) else {
            fatalError("Error encoding order!")
            
        }
        
        var resourse = Resource<Order?>(url: url)
        
        resourse.httpMethod = HttpMethod.post
        resourse.body = data
        
        return resourse
        
    }
    
}

extension Order {
    
    init?(_ vm: AddCoffeeOrderViewModel) {
        
        guard let name = vm.name,
            let email = vm.email,
            let selectedType = CoffeeType(rawValue: vm.selectedType!.lowercased()),
            let selectedSize = CoffeeSize(rawValue: vm.selectdSize!.lowercased())
            else {
                return nil
                
        }
        
        self.name = name
        self.email = email
        self.type = selectedType
        self.size = selectedSize
        
    }
    
}
