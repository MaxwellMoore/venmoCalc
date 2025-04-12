//
//  Calc.ViewModel.swift
//  venmoCalc
//
//  Created by Maxwell Lane Moore on 3/18/25.
//

import SwiftUI

class CalcViewModel: ObservableObject {
    @Published var itemCosts: [itemCost_t] = []
    @Published var subtotal: Double = 0
    @Published var tax: Double = 0
    @Published var tip: Double = 0

    var itemTotal: Double {
        itemCosts.reduce(0) {runningSum, currentItem in
            runningSum + currentItem.splitCost
        }
    }

    var quotient: Double {
        subtotal == 0 ? 0 : itemTotal / subtotal
    }

    var total: Double {
        itemTotal + tax * quotient + tip * quotient
    }

    func addItemCost() {
        let itemCost = itemCost_t(totalCost: 0.00, split: 1)
        itemCosts.append(itemCost)
    }

    func removeItemCost(at index: Int) {
        guard index < itemCosts.count else { return }
        itemCosts.remove(at: index)
    }
    
    func updateItemCost(at index: Int, totalCost: Double? = nil, split: Double? = 1) {
        guard itemCosts.indices.contains(index) else { return }

        if let newTotalCost = totalCost {
            itemCosts[index].totalCost = newTotalCost
        }
        if let newSplit = split {
            itemCosts[index].split = newSplit
        }
    }
    
    func incrementSplit(at index: Int) {
        guard itemCosts.indices.contains(index) else { return }
        itemCosts[index].split += 1
    }
    
    func decrementSplit(at index: Int) {
        guard itemCosts.indices.contains(index) else { return }
        itemCosts[index].split > 1 ? itemCosts[index].split -= 1 : ()
    }

    func clearAll() {
        itemCosts = []
        subtotal = 0
        tax = 0
        tip = 0
    }
}

