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
