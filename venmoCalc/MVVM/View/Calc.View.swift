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
            Spacer()
            Text("Total: $\(viewModel.calc.total, specifier: "%.2f")")
                .font(.title)
                .padding(.top, 10)
            List {
                // Item Costs Section
                Section(header: Text("Personal")) {
                    ForEach(viewModel.calc.itemCosts.indices, id: \.self) { index in
                        HStack {
                            Text("Item Cost:")
                            Spacer()
                            TextField("Item Cost", text: Binding(
                                get: { String(viewModel.calc.itemCosts[index]) },
                                set: { viewModel.updateItemCost(at: index, value: $0) }
                            ))
                            .frame(width: 120)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .multilineTextAlignment(.trailing)
                            
                            Button("X") {
                                viewModel.removeItemCost(at: index)
                            }
                            .foregroundColor(.red)
                        }
                    }

                    HStack {
                        Button("Add Item Cost") {
                            viewModel.addItemCost()
                        }
                        .foregroundColor(.blue)
                    }
                }
                
                // Subtotal, Tax, Tip Section
                Section(header: Text("Communal")) {
                    HStack {
                        Text("Subtotal:")
                        Spacer()
                        TextField("Subtotal", text: Binding(
                            get: { String(viewModel.calc.subtotal) },
                            set: { viewModel.calc.subtotal = Double($0) ?? 0 }
                        ))
                        .frame(width: 120)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Tax:")
                        Spacer()
                        TextField("Tax", text: Binding(
                            get: { String(viewModel.calc.tax) },
                            set: { viewModel.calc.tax = Double($0) ?? 0 }
                        ))
                        .frame(width: 120)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Tip:")
                        Spacer()
                        TextField("Tip", text: Binding(
                            get: { String(viewModel.calc.tip) },
                            set: { viewModel.calc.tip = Double($0) ?? 0 }
                        ))
                        .frame(width: 120)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Button("Clear All") {
                            viewModel.clearAll()
                        }
                        .foregroundColor(.red)
                    }
                }
            }
            .listStyle(.plain) // Removes extra spacing between sections

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
