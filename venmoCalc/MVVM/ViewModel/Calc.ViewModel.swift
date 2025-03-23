//
//  Calc.ViewModel.swift
//  venmoCalc
//
//  Created by Maxwell Lane Moore on 3/18/25.
//

import Foundation
import Combine

class CalcViewModel: ObservableObject {
    @Published var itemCosts: [Double] = []
    @Published var subtotal: Double = 0.0
    @Published var tax: Double = 0.0
    @Published var tip: Double = 0.0
    
    var personalSubtotal: Double
    {
        return itemCosts.reduce(0, +)
    }
    
    var quotient: Double
    {
        return personalSubtotal/subtotal
    }
    
    var totalAmount: Double
    {
        return quotient * (personalSubtotal + tax + tip)
    }
    
    func addItemCost(_ cost: Double)
    {
        itemCosts.append(cost)
    }
    
    func removeItemCost(at index: Int)
    {
        guard index >= 0 && index < itemCosts.count else { return }
        itemCosts.remove(at: index)
    }
}
