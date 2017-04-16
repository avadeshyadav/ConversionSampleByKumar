//
//  AKProductTableViewCell.swift
//  ConversionSampleByKumar
//
//  Created by Avadesh Kumar on 31/03/17.
//  Copyright © 2017 goibibo. All rights reserved.
//

import UIKit

class AKProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var transactionsLabel: UILabel!
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(with product: AKProduct) {
      
        productNameLabel.text = product.sku
        
        let count  = product.transactions?.count ?? 0
        transactionsLabel.text = "\(count) transactions"
    }

}
