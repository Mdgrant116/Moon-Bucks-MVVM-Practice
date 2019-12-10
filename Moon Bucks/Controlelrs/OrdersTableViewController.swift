//
//  OrdersTableViewController.swift
//  Moon Bucks
//
//  Created by Michael Grant on 11/27/19.
//  Copyright © 2019 Michael Grant. All rights reserved.
//

import Foundation
import UIKit



class OrdersTabelViewController: UITableViewController {
    
    var orderListViewModel = OrderListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateOrders()
    }
    
    private func populateOrders() {
        
        guard let coffeeOrdersUrl = URL(string: "https://guarded-retreat-82533.herokuapp.com/orders") else {
            fatalError("Url was incorrect")
        }
        
        
        let resource = Resource<[Order]>(url: coffeeOrdersUrl)
        WebService().load(resource: resource) { [weak self] result in
            
            switch result {
                
            case.success(let orders):
                self?.orderListViewModel.ordersViewModel = orders.map(OrderViewModel.init)
                self?.tableView.reloadData()
            case.failure(let error):
                print(error)
            }
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orderListViewModel.ordersViewModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let vm = self.orderListViewModel.orderViewModel(at: indexPath.row)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath)
        cell.textLabel?.text = vm.type
        cell.detailTextLabel?.text = vm.size
        return cell
    }
}
