//
//  AddOrderViewController.swift
//  Moon Bucks
//
//  Created by Michael Grant on 11/27/19.
//  Copyright © 2019 Michael Grant. All rights reserved.
//

import Foundation
import UIKit

class AddOrderViewController: UIViewController {
   
    private var vm = AddCoffeeOrderViewModel()
    
    
    @IBOutlet weak var tableView: UITableView!
    private var coffeeSizesSegmentedController: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    private func setupUI() {
        
        self.coffeeSizesSegmentedController = UISegmentedControl(items: self.vm.sizes)
        self.coffeeSizesSegmentedController.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(coffeeSizesSegmentedController)
        self.coffeeSizesSegmentedController.topAnchor.constraint(equalTo: self.tableView.bottomAnchor, constant: 20).isActive = true
        self.coffeeSizesSegmentedController.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
    }
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}


extension AddOrderViewController: UITableViewDelegate, UITableViewDataSource {
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return self.vm.types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeeType", for: indexPath)
        
        cell.textLabel?.text = self.vm.types[indexPath.row]
        
        return cell
    }
    
    
    
}
