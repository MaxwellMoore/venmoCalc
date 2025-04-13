//
//  Calc.View.swift
//  venmoCalc
//
//  Created by Maxwell Lane Moore on 3/18/25.
//

import SwiftUI

enum FieldFocus: Hashable {
    case item(index: Int)
    case communal(String)
}

struct ContentView: View {
    @StateObject private var viewModel = CalcViewModel()
    @FocusState private var focusedField: FieldFocus?
    
    private func moveToNextField() {
        if let current = focusedField {
            switch current {
            case .item(let index):
                if index + 1 < viewModel.itemCosts.count {
                    focusedField = .item(index: index + 1)
                } else {
                    focusedField = .communal("Subtotal")
                }
            case .communal("Subtotal"):
                focusedField = .communal("Tax")
            case .communal("Tax"):
                focusedField = .communal("Tip")
            case .communal("Tip"):
                focusedField = nil
            default:
                focusedField = nil
            }
        } else if !viewModel.itemCosts.isEmpty {
            focusedField = .item(index: 0)
        }
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(.systemBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Fixed Total View
                HStack {
                    Spacer()
                    Text("Total: $\(viewModel.total, specifier: "%.2f")")
                        .font(.title)
                        .padding(.horizontal)
                        .padding(.vertical, 16)
                        .background(Color(.systemBackground).opacity(0.95))
                        .frame(maxWidth: .infinity)
                    Spacer()
                }
                .zIndex(1)

                Divider()

                // Scrollable Content
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            
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
        
//                                            TextField("$0.00", value: $itemCost.totalCost, format: .number)
                                            TextField("$0.00", value: $itemCost.totalCost, format: .currency(code: "USD"))
                                                .frame(width: 100)
                                                .keyboardType(.decimalPad)
                                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                                .multilineTextAlignment(.trailing)
                                                .id(FieldFocus.item(index: index)) // For scrollTo
                                                .focused($focusedField, equals: .item(index: index))
        
                                            Button {
                                                viewModel.removeItemCost(at: index)
                                            } label: {
                                                Image(systemName: "trash")
                                                    .font(.headline)
                                                    .frame(maxHeight: .infinity)
                                            }
                                            .padding(.vertical, 4)
                                            .padding(.horizontal, 8)
                                            .foregroundColor(.white.opacity(0.85))
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
                                                Button {
                                                    viewModel.decrementSplit(at: index)
                                                } label: {
                                                    Image(systemName: "minus")
                                                        .font(.headline)
                                                        .frame(maxHeight: .infinity)
                                                }
                                                .foregroundColor(.white)
                                                .padding(6)
                                                .background(Color.gray.opacity(0.6))
                                                .cornerRadius(6)

                                                Button {
                                                    viewModel.incrementSplit(at: index)
                                                } label: {
                                                    Image(systemName: "plus")
                                                        .font(.headline)
                                                        .frame(maxHeight: .infinity)
                                                }
                                                .foregroundColor(.white)
                                                .padding(6)
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
                                        let newIndex = viewModel.addItemCost()
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.03) {
                                            focusedField = .item(index: newIndex)
                                        }
                                    }
                                    .padding(.vertical, 6)
                                    .padding(.horizontal, 12)
                                    .foregroundColor(.white)
                                    .background(Color.blue.opacity(0.8))
                                    .cornerRadius(6)
                                }
                                .padding(.horizontal)
                            }
                            .padding(.top)
        
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
                                        focusedField = nil
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
                        focusedField = nil
                    }
                    .onChange(of: focusedField) {
                        withAnimation {
                            if let field = focusedField {
                                proxy.scrollTo(field, anchor: .center)
                            }
                        }
                    }
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button("Next") {
                                moveToNextField()
                            }
                            .fontWeight(.semibold)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 12)
                            .foregroundColor(.white)
                            .background(Color.blue.opacity(0.8))
                            .cornerRadius(6)
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func communalRow(title: String, value: Binding<Double?>) -> some View {
        HStack {
            Text("\(title):")
            Spacer()
//            TextField("$0.00", value: value, format: .number)
            TextField("$0.00", value: value, format: .currency(code: "USD"))
                .frame(width: 100)
                .keyboardType(.decimalPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .multilineTextAlignment(.trailing)
                .id(FieldFocus.communal(title))
                .focused($focusedField, equals: .communal(title))
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
