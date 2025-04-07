//
//  AppCoordinator.swift
//  venmoCalc
//
//  Created by Maxwell Lane Moore on 3/18/25.
//

import SwiftUI

class AppCoordinator: ObservableObject
{
    @Published var currentView: AnyView = AnyView(ContentView())

    func navigateTo(_ view: AnyView)
    {
        currentView = view
    }
}


//import SwiftUI
//
//struct DynamicNumberInputView: View {
//    @State private var numbers: [String] = [""] // Start with one input field
//
//    var sum: Double {
//        numbers.compactMap { Double($0) }.reduce(0, +)
//    }
//
//    var body: some View {
//        VStack(spacing: 20) {
//            Text("Total Sum: \(sum, specifier: "%.2f")")
//                .font(.title)
//
//            ScrollView {
//                VStack(spacing: 10) {
//                    ForEach(numbers.indices, id: \.self) { index in
//                        HStack {
//                            TextField("Enter a number", text: $numbers[index])
//                                .keyboardType(.decimalPad)
//                                .textFieldStyle(RoundedBorderTextFieldStyle())
//                                .frame(maxWidth: .infinity)
//
//                            Button(action: {
//                                removeNumber(at: index)
//                            }) {
//                                Image(systemName: "minus.circle.fill")
//                                    .foregroundColor(.red)
//                            }
//                        }
//                        .padding(.horizontal)
//                    }
//                }
//            }
//            .frame(height: 250)
//
//            Button(action: addNumber) {
//                Text("Add Another Number")
//                    .font(.headline)
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//        }
//        .padding()
//    }
//
//    private func addNumber() {
//        numbers.append("") // Add an empty input field
//    }
//
//    private func removeNumber(at index: Int) {
//        if numbers.count > 1 { // Prevent removing the last field
//            numbers.remove(at: index)
//        }
//    }
//}
//
//struct DynamicNumberInputView_Previews: PreviewProvider {
//    static var previews: some View {
//        DynamicNumberInputView()
//    }
//}
