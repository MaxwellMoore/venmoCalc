//
//  Calc.swift
//  venmoCalc
//
//  Created by Maxwell Lane Moore on 3/18/25.
//

//struct itemCost_t {
//    var totalCost: Double
//    var portion: Double
//    var portionedCost: Double {
//        totalCost * portion
//    }
//}

import SwiftUI

struct itemCost_t: Identifiable, Equatable {
    var id = UUID()  // Required for Identifiable
    var totalCost: Double
    var split: Double

    var splitCost: Double {
        return totalCost / split
    }
}

struct Calc {
    var itemCosts: [itemCost_t]
    var subtotal: Double
    var tax: Double
    var tip: Double
    
    var itemTotal: Double {
        itemCosts.reduce(0) {runningSum, currentItem in
            runningSum + currentItem.splitCost
        }
    }
    
    var quotient: Double {
        subtotal == 0 ? 0 : itemTotal / subtotal
    }
    
    var total: Double {
        quotient * (subtotal + tax + tip)
    }
}
