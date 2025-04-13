//
//  Calc.View.swift
//  venmoCalc
//
//  Created by Maxwell Lane Moore on 3/18/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CalcViewModel()
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                Spacer(minLength: 16)
                
                // Total
                HStack {
                    Spacer()
                    Text("Total: $\(viewModel.total, specifier: "%.2f")")
                        .font(.title)
                        .padding(.horizontal)
                    Spacer()
                }
                
                Divider()
                
                // Personal Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("Personal")
                        .font(.headline)
                        .padding(.horizontal)

                    ForEach(Array($viewModel.itemCosts.enumerated()), id: \.element.id) { index, $itemCost in
                        VStack {
                            HStack {
                                Text("Item Cost:")
                                
                                Spacer()

                                TextField("$0.00", value: $itemCost.totalCost, format: .number)
                                    .frame(width: 100)
                                    .keyboardType(.decimalPad)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .multilineTextAlignment(.trailing)
                                    .focused($isTextFieldFocused)

                                Button("X") {
                                    viewModel.removeItemCost(at: index)
                                }
                                .padding(.vertical, 4)
                                .padding(.horizontal, 8)
                                .foregroundColor(.white)
                                .background(Color.red.opacity(0.8))
                                .cornerRadius(6)
                            }
                            .padding(.horizontal)
                            
                            HStack {
                                HStack {
                                    Text("Split Cost: $\(itemCost.splitCost, specifier: "%.2f")")
                                        .foregroundColor(.gray)
                                    
                                    Spacer()
                                    
                                    Text("Split: 1/\(itemCost.split, specifier: "%.0f")")
                                        .foregroundColor(.gray)
                                }
                                .padding(.vertical, 6)
                                .padding(.horizontal, 12)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(6)
                                
                                HStack {
                                    Button("-") {
                                        viewModel.decrementSplit(at: index)
                                    }
                                    .padding(.vertical, 4)
                                    .padding(.horizontal, 8)
                                    .foregroundColor(.white)
                                    .background(Color.gray.opacity(0.6))
                                    .cornerRadius(6)
                                    
                                    Button("+") {
                                        viewModel.incrementSplit(at: index)
                                    }
                                    .padding(.vertical, 4)
                                    .padding(.horizontal, 8)
                                    .foregroundColor(.white)
                                    .background(Color.gray.opacity(0.6))
                                    .cornerRadius(6)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }

                    
                    HStack {
                        Text("Item Total: $\(viewModel.itemTotal ?? 0, specifier: "%.2f")")
                            .foregroundColor(.gray)
                            .padding(.vertical, 6)
                            .padding(.horizontal, 12)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(6)

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
                    .padding(.horizontal)
                }
                
                Divider()

                // Communal Section
                VStack(alignment: .leading, spacing: 16) {
                    Text("Communal")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    VStack {
                        communalRow(title: "Subtotal", value: $viewModel.subtotal)

                        detailLabel(title: "Quotient ( itemTotal / subtotal ):",
                                    value: String(format: "%.2f", viewModel.quotient) + "%")
                    }

                    VStack {
                        communalRow(title: "Tax", value: $viewModel.tax)

                        detailLabel(title: "Fractional Product:",
                                    value: "$" + String(format: "%.2f", viewModel.taxFractionalProduct))
                    }

                    VStack {
                        communalRow(title: "Tip", value: $viewModel.tip)

                        detailLabel(title: "Fractional Product:",
                                    value: "$" + String(format: "%.2f", viewModel.tipFractionalProduct))
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
                        Spacer()
                    }
                }
            }
            .padding(.bottom, 20)
        }
        .onTapGesture {
            isTextFieldFocused = false // Remove focus when tapping outside
        }
    }
    
    @ViewBuilder
    private func communalRow(title: String, value: Binding<Double?>) -> some View {
        HStack {
            Text("\(title):")
            Spacer()
            TextField("$0.00", value: value, format: .number)
                .frame(width: 100)
                .keyboardType(.decimalPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .multilineTextAlignment(.trailing)
                .focused($isTextFieldFocused)
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func detailLabel(title: String, value: String) -> some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 12)
        .foregroundColor(.gray)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(6)
        .padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
