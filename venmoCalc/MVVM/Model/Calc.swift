//
//  Calc.swift
//  venmoCalc
//
//  Created by Maxwell Lane Moore on 3/18/25.
//

struct Calc {
    var itemCosts: [Double]
    var subtotal: Double
    var tax: Double
    var tip: Double
    
    var itemTotal: Double {
        itemCosts.reduce(0, +)
    }
    
    var quotient: Double {
        subtotal == 0 ? 0 : itemTotal / subtotal
    }
    
    var total: Double {
        quotient * (subtotal + tax + tip)
    }
}

// personalSubtotal = $8.72
// subtotal = $22.73
// quotient = 0.3836339
// tax = $3.82
// tip = $7.21

// M1 = $12.9514
// M2 = $12.9514
