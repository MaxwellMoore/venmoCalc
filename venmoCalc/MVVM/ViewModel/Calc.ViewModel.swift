//
//  Calc.ViewModel.swift
//  venmoCalc
//
//  Created by Maxwell Lane Moore on 3/18/25.
//

import SwiftUI

class CalcViewModel: ObservableObject {
    @Published var itemCosts: [itemCost_t] = []
    @Published var subtotal: Double? = nil
    @Published var tax: Double? = nil
    @Published var tip: Double? = nil
    
    var itemTotal: Double? {
        itemCosts.reduce(0) {runningSum, currentItem in
            runningSum + currentItem.splitCost
        }
    }
    
    var quotient: Double {
        let safeItemTotal = itemTotal ?? 0
        let safeSubtotal = subtotal ?? 0
        return (safeItemTotal == 0 || safeSubtotal == 0) ? 1 : safeItemTotal / safeSubtotal
    }
    
    var taxFractionalProduct: Double {
        let safeTax = tax ?? 0
        return quotient * safeTax
    }
    
    var tipFractionalProduct: Double {
        let safeTip = tip ?? 0
        return quotient * safeTip
    }

    var total: Double {
        let safeItemTotal = itemTotal ?? 0
        let safeSubtotal = subtotal ?? 0
        let safeTax = tax ?? 0
        let safeTip = tip ?? 0
        
        // If the user didn't purchase anything, they shouldn't own anything
        // for tax and tip
        return safeItemTotal == 0 ? 0 : quotient * (safeSubtotal + safeTax + safeTip)
    }
    
    func addItemCost() -> Int {
        let newItem = itemCost_t(id: UUID(), totalCost: nil, split: 1)
        itemCosts.append(newItem)
        return itemCosts.count - 1
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
        subtotal = nil
        tax = nil
        tip = nil
    }
}

