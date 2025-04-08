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
                            .frame(width: 100)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .multilineTextAlignment(.trailing)
                            .padding(.vertical, 2)
                            
                            Button("X") {
                                viewModel.removeItemCost(at: index)
                            }
                            .padding(.vertical, 4)
                            .padding(.horizontal, 8)
                            .foregroundColor(.white)
                            .background(Color.red.opacity(0.8))
                            .cornerRadius(6)
                        }
                    }

                    HStack {
                        Text("Item Total: $\(viewModel.calc.itemTotal, specifier: "%.2f")")
                            .padding(.vertical, 6)
                            .padding(.horizontal, 16)
                            .foregroundColor(.gray)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                        Spacer()
                        Button("+ Item") {
                            viewModel.addItemCost()
                        }
                        .padding(.vertical, 6)
                        .padding(.horizontal, 12)
                        .foregroundColor(.white)
                        .background(Color.blue.opacity(0.8))
                        .cornerRadius(6)
                    }
                    
                    // Trick Swift UI to remove the bottom row separator, but not the top
                    Color.clear
                        .frame(height: 1)
                        .listRowSeparator(.hidden)
                }
                
                // Subtotal, Tax, Tip Section
                Section(header: Text("Communal")) {
                    VStack {
                        HStack {
                            Text("Subtotal:")
                            Spacer()
                            TextField("Subtotal", text: Binding(
                                get: { String(viewModel.calc.subtotal) },
                                set: { viewModel.calc.subtotal = Double($0) ?? 0 }
                            ))
                            .frame(width: 100)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .multilineTextAlignment(.trailing)
                        }
                        
                        HStack {
                            Text("Quotient ( itemTotal / subtotal ):")
                            Spacer()
                            Text("\(viewModel.calc.quotient, specifier: "%.2f")%")
                        }
                        .padding(.vertical, 6)
                        .padding(.horizontal, 16)
                        .foregroundColor(.gray)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(6)
                    }
                    
                    VStack {
                        HStack {
                            Text("Tax:")
                            Spacer()
                            TextField("Tax", text: Binding(
                                get: { String(viewModel.calc.tax) },
                                set: { viewModel.calc.tax = Double($0) ?? 0 }
                            ))
                            .frame(width: 100)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .multilineTextAlignment(.trailing)
                        }
                        
                        HStack {
                            Text("Fractional Product:")
                            Spacer()
                            Text("$\(viewModel.calc.tax * viewModel.calc.quotient, specifier: "%.2f")")
                        }
                        .padding(.vertical, 6)
                        .padding(.horizontal, 16)
                        .foregroundColor(.gray)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(6)
                        
                        
                    }
                    
                    VStack {
                        HStack {
                            Text("Tip:")
                            Spacer()
                            TextField("Tip", text: Binding(
                                get: { String(viewModel.calc.tip) },
                                set: { viewModel.calc.tip = Double($0) ?? 0 }
                            ))
                            .frame(width: 100)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .multilineTextAlignment(.trailing)
                        }
                        
                        HStack {
                            Text("Fractional Product:")
                            Spacer()
                            Text("$\(viewModel.calc.tip * viewModel.calc.quotient, specifier: "%.2f")")
                        }
                        .padding(.vertical, 6)
                        .padding(.horizontal, 16)
                        .foregroundColor(.gray)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(6)
                    }
                    
                    
                    
                    HStack {
                        Spacer()
                        Button("Clear All") {
                            viewModel.clearAll()
                        }
                        .fontWeight(.semibold)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 12)
                        .foregroundColor(.white)
                        .background(Color.red.opacity(0.8))
                        .cornerRadius(6)
                    }
                    
                    Color.clear
                        .frame(height: 1)
                        .listRowSeparator(.hidden)
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
