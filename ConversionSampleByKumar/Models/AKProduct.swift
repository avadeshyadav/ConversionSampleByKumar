//
//  AKProduct.swift
//  ConversionSampleByKumar
//
//  Created by Avadesh Kumar on 31/03/17.
//  Copyright © 2017 goibibo. All rights reserved.
//

import Foundation


class AKProduct {

    var sku: String?
    var transactions: Array<AKTransaction>?
    var totalGBPValue: Double?
    
    static var rateList: Array<Dictionary<String, Any>>? {
        return getPlistDataArray(from: "rates")
    }
    
    static func getPlistDataArray(from plistName: String) -> Array<Dictionary<String, Any>>? {
       
        guard let plistPath = Bundle.main.path(forResource: plistName, ofType: "plist") else {
            return nil
        }
        
        return NSArray(contentsOfFile: plistPath) as? Array<Dictionary<String, Any>>
    }
    
    static func getTranscationsDetails() -> Dictionary<String, Any>? {
    
        if let details = AKProduct.getPlistDataArray(from: "transactions") {
            
            var allDataDict = Dictionary<String, Any>()
            
            for productDetail in details {
                
                guard let sku = productDetail["sku"] as? String else {
                    continue
                }
                
                if var oldData = allDataDict[sku] as? Array<AKTransaction> {
                    oldData.append(AKTransaction(with: productDetail))
                    allDataDict[sku] = oldData
                }
                else {
                    allDataDict[sku] = [AKTransaction(with: productDetail)];
                }
            }
                        
            return allDataDict
            
        }
        else {
            print("Error while reading data")
            return nil
        }
    }
    
    static func getProductObjects() -> Array<AKProduct>? {
    
        guard let productDetails = getTranscationsDetails() else {
            return nil
        }
        
        var products = Array<AKProduct>()
        
        for (sku, transactions) in productDetails {
        
            print(sku);
            let product = AKProduct()
            product.sku = sku
            product.transactions = transactions as? Array<AKTransaction>
            products.append(product)
        
        }
        
        return products
    }
}


class AKTransaction {
    
    var currency: String?
    var amount: Double = 0
    var gbpValue: Double?
    
    init(with details: Dictionary<String, Any>) {
        
        self.currency = details["currency"] as? String
        
        if let amountString = details["amount"] as? String, let amount = Double(amountString) {
            self.amount = amount
        }
    }
}
