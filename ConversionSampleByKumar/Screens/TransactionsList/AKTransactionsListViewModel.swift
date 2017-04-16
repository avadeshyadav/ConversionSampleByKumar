//
//  AKTransactionsListViewModel.swift
//  ConversionSampleByKumar
//
//  Created by Avadesh Kumar on 01/04/17.
//  Copyright © 2017 goibibo. All rights reserved.
//

import UIKit

let GBPCurrencyKey = "GBP"

class AKTransactionsListViewModel: NSObject {

    var operationQueue = OperationQueue()
    
    deinit {
        operationQueue.cancelAllOperations()
    }
    
    func makeConversionTo(product: AKProduct, with block: @escaping (Bool) -> ()) {
        
        operationQueue.addOperation {
            
            var isSuccess = false
            
            if let _ = AKProduct.rateList, let transactions = product.transactions  {
                
                var totalGBPValue: Double = 0.0
                
                for transaction in transactions {
                    
                    if transaction.currency == GBPCurrencyKey {
                        transaction.gbpValue = Double(transaction.amount)
                    }
                    else {
                        transaction.gbpValue = self.calculateGBPValue(from : transaction)
                    }
                    
                    if let gbpValue = transaction.gbpValue {
                        totalGBPValue += gbpValue
                    }
                }
                
                product.totalGBPValue = totalGBPValue
                isSuccess = true
            }
            
            DispatchQueue.main.async {
                block(isSuccess)
            }
        }
    }
    
    func calculateGBPValue(from transaction: AKTransaction) -> Double {
        return transaction.amount * getGBPConversionRatio(from: transaction.currency)
    }
    
    //Due to time shortage I am doing it here, otherwise could have moved to proper place
    func getGBPConversionRatio(from currency: String?) -> Double {

        guard let _currency = currency else {
            return 1.0
        }
        
        if let rateList = AKProduct.rateList {
        
            var nonDirectMatchingRate: String?
            var nonDirectMatchingCurrency: String?
            
            for rateDetails in rateList {
            
                let toCurrency = rateDetails["to"] as? String
                let fromCurrency = rateDetails["from"] as? String
                let rate = rateDetails["rate"] as? String
                
                if fromCurrency == _currency && toCurrency == GBPCurrencyKey, rate != nil {
                    return Double(rate!) ?? 1.0
                }
                else if toCurrency == GBPCurrencyKey, rate != nil {
                    nonDirectMatchingRate = rate
                    nonDirectMatchingCurrency = fromCurrency
                }
            }
            
            return (Double(nonDirectMatchingRate!) ?? 1.0) * getGBPConversionRatio(from: nonDirectMatchingCurrency)
        }
        else {
            return 1.0
        }
    }

 }
