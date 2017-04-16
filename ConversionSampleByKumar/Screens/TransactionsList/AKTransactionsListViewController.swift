//
//  AKTransactionsListViewController.swift
//  ConversionSampleByKumar
//
//  Created by Avadesh Kumar on 31/03/17.
//  Copyright © 2017 goibibo. All rights reserved.
//

import UIKit

class AKTransactionsListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var totalValueLabel: UILabel!

    var product: AKProduct?
    var model = AKTransactionsListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doInitialConfigurations()
        convertAndLoadTransactions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let skuName = product?.sku ?? ""
        self.title = "Transactions for \(skuName)"
    }

    //MARK: Private methods
    func doInitialConfigurations() {
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func convertAndLoadTransactions() {
    
        guard let _ = product else {
            //Show alert here
            return
        }
        
        if let totalValue = product?.totalGBPValue {
            self.totalValueLabel.text = "Total: €\(totalValue)"
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
            return
        }
        
        model.makeConversionTo(product: self.product!) { [weak self] (success) in
            
            if success {
                
                if let totalValue = self?.product?.totalGBPValue {
                    self?.totalValueLabel.text = "Total: €\(totalValue)"
                    self?.tableView.reloadData()
                }
            }
            else {
            // Show alert here
            }
            
            self?.activityIndicator.stopAnimating()
        }
    }
}


//MARK:- UITableViewDataSource, UITableViewDelegate
typealias TransactionsTableDelegatesAndDataSource = AKTransactionsListViewController

extension TransactionsTableDelegatesAndDataSource: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return product?.transactions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AKTransactionsTableViewCell") as! AKTransactionsTableViewCell
        cell.configureCell(with: product?.transactions?[indexPath.row])
        return cell
    }
}
