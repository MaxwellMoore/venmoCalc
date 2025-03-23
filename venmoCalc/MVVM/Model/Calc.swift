//
//  Calc.swift
//  venmoCalc
//
//  Created by Maxwell Lane Moore on 3/18/25.
//

import Foundation

struct Calc
{
    var itemCosts: [Double]
    var subtotal: Double
    var quotient: Double
    var tax: Double
    var tip: Double
    
    var personalSubtotal: Double
    {
        return itemCosts.reduce(0, +)
    }
    
    var totalAmount: Double
    {
        return quotient * (subtotal + tax + tip)
    }
    
    // personalSubtotal = $8.72
    // subtotal = $22.73
    // quotient = 0.3836339
    // tax = $3.82
    // tip = $7.21
    
    // M1 = $12.9514
    // M2 = $12.9514
}
