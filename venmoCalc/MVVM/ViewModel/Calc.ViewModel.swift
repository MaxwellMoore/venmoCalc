//
//  Calc.ViewModel.swift
//  venmoCalc
//
//  Created by Maxwell Lane Moore on 3/18/25.
//

import SwiftUI

class CalcViewModel: ObservableObject {
    @Published var itemCosts: [Double] = [0]
    @Published var subtotal: Double = 0
    @Published var tax: Double = 0
    @Published var tip: Double = 0

    var itemTotal: Double {
        itemCosts.reduce(0, +)
    }

    var quotient: Double {
        subtotal == 0 ? 0 : itemTotal / subtotal
    }

    var total: Double {
        itemTotal + tax * quotient + tip * quotient
    }

    func addItemCost() {
        itemCosts.append(0)
    }

    func removeItemCost(at index: Int) {
        guard index < itemCosts.count else { return }
        itemCosts.remove(at: index)
    }

    func updateItemCost(at index: Int, value: String) {
        if let newValue = Double(value), index < itemCosts.count {
            itemCosts[index] = newValue
        }
    }

    func clearAll() {
        itemCosts = [0]
        subtotal = 0
        tax = 0
        tip = 0
    }
}

