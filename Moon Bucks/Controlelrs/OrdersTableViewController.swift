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
        
        WebService().load(resource: Order.all) { [weak self] result in
            
            switch result {
                
            case.success(let orders):
                
                self?.orderListViewModel.ordersViewModel = orders.map(OrderViewModel.init)
                self?.tableView.reloadData()
                
            case.failure(let error):
                
                print(error)
                
            }
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let navC = segue.destination as? UINavigationController,
            let addCoffeeOrderVC = navC.viewControllers.first as? AddOrderViewController
            
            else {
                
                fatalError("Error performing segue")
                
        }
        
        addCoffeeOrderVC.delegate = self
        
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

extension OrdersTabelViewController: AddCoffeeOrderDelegate {
    
    func addCoffeeOrderViewControllerDidSave(order: Order, controller: UIViewController) {
        
        controller.dismiss(animated: true, completion: nil)
        let orderVM = OrderViewModel(order: order)
        self.orderListViewModel.ordersViewModel.append(orderVM)
        self.tableView.insertRows(at: [IndexPath.init(row: self.orderListViewModel.ordersViewModel.count - 1, section: 0)], with: .automatic)
        
    }
    
    func addCoffeeOrderViewControllerDidClose(controller: UIViewController) {
        
        controller.dismiss(animated: true, completion: nil)
        
    }
    
}
