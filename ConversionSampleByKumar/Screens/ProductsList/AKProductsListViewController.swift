//
//  AKProductsListViewController.swift
//  ConversionSampleByKumar
//
//  Created by Avadesh Kumar on 31/03/17.
//  Copyright © 2017 goibibo. All rights reserved.
//

import UIKit

class AKProductsListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var model = AKProductsListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        doInitialConfigurations()
       fetchAndReloadProducts()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let transactionsVC = segue.destination as? AKTransactionsListViewController {
            transactionsVC.product = sender as? AKProduct
        }
    }
 
    //MARK: Private methods
    func doInitialConfigurations() {
    
        self.title = "Products"
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func fetchAndReloadProducts() {
        
        tableView.isHidden = true
        model.fetchProducts { [weak self] (success) in
            
            if success {
                self?.tableView.reloadData()
            }
            else {
            // Show error here
            }
            self?.activityIndicator.stopAnimating()
            self?.tableView.isHidden = !success
        }
    }
}


//MARK:- UITableViewDataSource, UITableViewDelegate
typealias TableDelegatesAndDataSource = AKProductsListViewController

extension TableDelegatesAndDataSource: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.producstList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AKProductTableViewCell") as! AKProductTableViewCell
        cell.configureCell(with: model.producstList[indexPath.row])
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ShowTransactionsListSegue", sender: model.producstList[indexPath.row])
    }
}

