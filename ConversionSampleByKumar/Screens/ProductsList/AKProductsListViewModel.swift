//
//  AKProductsListViewModel.swift
//  ConversionSampleByKumar
//
//  Created by Avadesh Kumar on 01/04/17.
//  Copyright © 2017 goibibo. All rights reserved.
//

import UIKit

class AKProductsListViewModel: NSObject {

    var producstList = Array<AKProduct>()
    var operationQueue = OperationQueue()
    
    deinit {
        operationQueue.cancelAllOperations()
    }
    
    func fetchProducts(with block: @escaping (Bool) -> ()) {
    
        operationQueue.addOperation {
          
            var isSuccess = false
            if let products = AKProduct.getProductObjects() {
               
                self.producstList = products
                isSuccess = true
            }
            
            self.producstList = (self.producstList.sorted { $0.sku! < $1.sku! })

            DispatchQueue.main.async {
                block(isSuccess)
            }
        }
    }
  

}
