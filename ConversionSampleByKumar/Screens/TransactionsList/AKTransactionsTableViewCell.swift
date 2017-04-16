//
//  AKTransactionsTableViewCell.swift
//  ConversionSampleByKumar
//
//  Created by Avadesh Kumar on 01/04/17.
//  Copyright © 2017 goibibo. All rights reserved.
//

import UIKit

class AKTransactionsTableViewCell: UITableViewCell {

    @IBOutlet weak var originalAmountLabel: UILabel!
    @IBOutlet weak var gbpAmountLabel: UILabel!
    

    func configureCell(with transaction: AKTransaction?) {
        
        guard let _ = transaction else {
            return
        }
        
        if let amount = transaction?.amount, let currency = transaction?.currency {
            originalAmountLabel.text = currency + ": \(amount)"
        }
        
        if let amount = transaction?.gbpValue {
            gbpAmountLabel.text =  "€: \(amount)"
        }
    }
}
