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
                Text("Total: $\(viewModel.total, specifier: "%.2f")")
                    .font(.title)
                    .padding(.horizontal)
                
                Divider()
                
                // Personal Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("Personal")
                        .font(.headline)
                        .padding(.horizontal)

                    ForEach(viewModel.itemCosts, id: \.self) { itemCost in
                        HStack {
                            Text("Item Cost:")
                            Spacer()
                            TextField("Item Cost", text: Binding(
                                get: { String(itemCost) },
                                set: { viewModel.updateItemCost(at: viewModel.itemCosts.firstIndex(of: itemCost) ?? 0, value: $0) }
                            ))
                            .frame(width: 100)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .multilineTextAlignment(.trailing)
                            .focused($isTextFieldFocused)

                            Button("X") {
                                if let index = viewModel.itemCosts.firstIndex(of: itemCost) {
                                    viewModel.removeItemCost(at: index)
                                }
                            }
                            .padding(.vertical, 4)
                            .padding(.horizontal, 8)
                            .foregroundColor(.white)
                            .background(Color.red.opacity(0.8))
                            .cornerRadius(6)
                        }
                        .padding(.horizontal)
                    }

                    HStack {
                        Text("Item Total: $\(viewModel.itemTotal, specifier: "%.2f")")
                            .foregroundColor(.gray)
                            .padding(8)
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
                                    value: "$" + String(format: "%.2f", (viewModel.tax * viewModel.quotient)))
                    }

                    VStack {
                        communalRow(title: "Tip", value: $viewModel.tip)

                        detailLabel(title: "Fractional Product:",
                                    value: "$" + String(format: "%.2f", (viewModel.tip * viewModel.quotient)))
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
    private func communalRow(title: String, value: Binding<Double>) -> some View {
        HStack {
            Text("\(title):")
            Spacer()
            TextField(title, value: value, format: .number)
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
        .padding(.horizontal)
        .foregroundColor(.gray)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(6)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
