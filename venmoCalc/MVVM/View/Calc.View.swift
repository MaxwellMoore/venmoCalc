//
//  Calc.View.swift
//  venmoCalc
//
//  Created by Maxwell Lane Moore on 3/18/25.
//

import SwiftUI

struct CalcView: View {
    @StateObject var viewModel = CalcViewModel()
    @State private var newItemCost = ""

    var body: some View {
        VStack {
            List {
                ForEach(viewModel.itemCosts.indices, id: \.self) { index in
                    HStack {
                        Text("Item \(index + 1): \(viewModel.itemCosts[index], specifier: "%.2f")")
                        Spacer()
                        Button(action: { viewModel.removeItemCost(at: index) }) {
                            Image(systemName: "trash").foregroundColor(.red)
                        }
                    }
                }
            }

            TextField("Enter item cost", text: $newItemCost)
                .keyboardType(.decimalPad)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button("Add Item") {
                if let cost = Double(newItemCost) {
                    viewModel.addItemCost(cost)
                    newItemCost = ""
                }
            }
            .buttonStyle(.borderedProminent)

            VStack(spacing: 10) {
                Text("Personal Subtotal: $\(viewModel.personalSubtotal, specifier: "%.2f")")
                Text("Total Amount (With Tax & Tip): $\(viewModel.totalAmount, specifier: "%.2f")")
            }
            .padding()
        }
        .navigationTitle("Venmo Calculator")
    }
}

struct CalcView_Previews: PreviewProvider {
    static var previews: some View {
        CalcView(viewModel: mockViewModel)
            .previewLayout(.sizeThatFits)
    }

    // Create a mock ViewModel with sample data
    static var mockViewModel: CalcViewModel {
        let viewModel = CalcViewModel()
        viewModel.addItemCost(12.99)
        viewModel.addItemCost(8.50)
        viewModel.addItemCost(5.25)
        return viewModel
    }
}

