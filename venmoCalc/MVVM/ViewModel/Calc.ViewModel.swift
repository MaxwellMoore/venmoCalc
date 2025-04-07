//
//  Calc.ViewModel.swift
//  venmoCalc
//
//  Created by Maxwell Lane Moore on 3/18/25.
//

import SwiftUI

class CalcViewModel: ObservableObject {
    @Published var calc = Calc(itemCosts: [0], subtotal: 0, tax: 0, tip: 0)
    
    func addItemCost() {
        calc.itemCosts.append(0)
    }
    
    func removeItemCost(at index: Int) {
        guard index < calc.itemCosts.count else { return }
        calc.itemCosts.remove(at: index)
    }
    
    func updateItemCost(at index: Int, value: String) {
        if let newValue = Double(value), index < calc.itemCosts.count {
            calc.itemCosts[index] = newValue
        }
    }
    
    func clearAll() {
        calc = Calc(itemCosts: [0], subtotal: 0, tax: 0, tip: 0)
    }
}
