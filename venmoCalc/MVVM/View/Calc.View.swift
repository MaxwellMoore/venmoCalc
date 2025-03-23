//
//  Calc.View.swift
//  venmoCalc
//
//  Created by Maxwell Lane Moore on 3/18/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CalcViewModel()
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.calc.itemCosts.indices, id: \ .self) { index in
                    HStack {
                        TextField("Item Cost", text: Binding(
                            get: { String(viewModel.calc.itemCosts[index]) },
                            set: { viewModel.updateItemCost(at: index, value: $0) }
                        ))
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Button("Remove") {
                            viewModel.removeItemCost(at: index)
                        }
                        .foregroundColor(.red)
                    }
                }
                
                Button("Add Item Cost") {
                    viewModel.addItemCost()
                }
            }
            .frame(height: 300)
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Subtotal:")
                    TextField("Subtotal", text: Binding(
                        get: { String(viewModel.calc.subtotal) },
                        set: { viewModel.calc.subtotal = Double($0) ?? 0 }
                    ))
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                HStack {
                    Text("Tax:")
                    TextField("Tax", text: Binding(
                        get: { String(viewModel.calc.tax) },
                        set: { viewModel.calc.tax = Double($0) ?? 0 }
                    ))
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                HStack {
                    Text("Tip:")
                    TextField("Tip", text: Binding(
                        get: { String(viewModel.calc.tip) },
                        set: { viewModel.calc.tip = Double($0) ?? 0 }
                    ))
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Text("Total: \(viewModel.calc.total, specifier: "%.2f")")
                    .font(.title)
                    .padding(.top, 10)
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//struct CalculatorView: View {
//    @State private var itemCosts: [String] = [""]
//    @State private var sum: String = ""
//    @State private var subtotal: String = ""
//    @State private var tax: String = ""
//    @State private var tip: String = ""
//    
//    // Calculate the quotient and fractionalProduct in real-time
//    var quotient: Double {
//        guard let itemCostValue = Double(sum), let subtotalValue = Double(subtotal), subtotalValue != 0 else {
//            return 0
//        }
//        return itemCostValue / subtotalValue
//    }
//    
//    var fractionalProduct: Double {
//        let subtotalValue = Double(subtotal) ?? 0
//        let taxValue = Double(tax) ?? 0
//        let tipValue = Double(tip) ?? 0
//        return quotient * (subtotalValue + taxValue + tipValue)
//    }
//    
//    //? how are quotient and fractionalProduct dynamically updated?
//    
//    var body: some View {
//        VStack {
//            // Calculated Results
//            Text("Quotient: \(String(format: "%.2f", quotient))")
//                .padding()
//            
//            Text("Fractional Product: \(String(format: "%.2f", fractionalProduct))")
//                .padding()
//            
//            // Item Cost Input
//            TextField("Item Cost", text: $itemCost)
//                .keyboardType(.decimalPad)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//            
//            // Subtotal Input
//            TextField("Subtotal", text: $subtotal)
//                .keyboardType(.decimalPad)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//            
//            // Tax Input
//            TextField("Tax", text: $tax)
//                .keyboardType(.decimalPad)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//            
//            // Tip Input
//            TextField("Tip", text: $tip)
//                .keyboardType(.decimalPad)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//            
//            Spacer()
//        }
//        .padding()
//    }
//}
//
//struct CalculatorView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalculatorView()
//    }
//}
